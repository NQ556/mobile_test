import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test/core/common/entities/user.dart';
import 'package:mobile_test/core/utils/asset_manager.dart';
import 'package:mobile_test/core/utils/color_manager.dart';
import 'package:mobile_test/core/utils/font_manager.dart';
import 'package:mobile_test/core/utils/route_manager.dart';
import 'package:mobile_test/core/utils/string_manager.dart';
import 'package:mobile_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_test/features/home/presentation/bloc/item_bloc.dart';
import 'package:mobile_test/features/home/presentation/widgets/food_widget.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ItemBloc>().add(LoadItemsEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onLogOutPressed() {
    context.read<AuthBloc>().add(
          LogOutEvent(),
        );
  }

  void _onScroll() {
    final state = context.read<ItemBloc>().state;

    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom && state is ItemLoadedState && !state.hasReachedMax) {
        context
            .read<ItemBloc>()
            .add(LoadMoreItemsEvent(offset: state.items.length));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Container(
              color: ColorManager.background,
              width: double.infinity,
              child: Stack(
                children: [
                  //
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringManager.appName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          "Welcome ${widget.user.username}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorManager.primary,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 180,
                      top: 50,
                      bottom: 20,
                    ),
                    child: Image.asset(
                      AssetManager.ramen,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),

            //
            SizedBox(
              height: 30,
            ),

            //
            BlocBuilder<ItemBloc, ItemState>(
              builder: (context, state) {
                if (state is ItemLoadedState) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<ItemBloc>().add(RefreshItemsEvent());
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          return FoodWidget(food: state.items[index]);
                        },
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),

            //
            SizedBox(
              height: 10,
            ),

            //
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLogOutSuccessState) {
                  Navigator.pushReplacementNamed(context, Routes.signInRoute);
                }
              },
              builder: (context, state) {
                return TextButton(
                  child: Text(
                    StringManager.logOut,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorManager.primary,
                        fontWeight: FontWeightManager.bold),
                  ),
                  onPressed: _onLogOutPressed,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

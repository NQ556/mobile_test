import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';
import 'package:mobile_test/features/home/domain/usecases/item_load_items.dart';
import 'package:mobile_test/features/home/domain/usecases/item_load_more_items.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemLoadItems _itemLoadItems;
  final ItemLoadMoreItems _itemLoadMoreItems;

  ItemBloc({
    required ItemLoadItems itemLoadItems,
    required ItemLoadMoreItems itemLoadMoreItems,
  })  : _itemLoadItems = itemLoadItems,
        _itemLoadMoreItems = itemLoadMoreItems,
        super(ItemInitial()) {
    on<ItemEvent>((_, emit) {
      //emit(ItemLoadingState());
    });
    on<LoadItemsEvent>(_onLoadItems);
    on<RefreshItemsEvent>(_onRefreshItems);
    on<LoadMoreItemsEvent>(_onLoadMoreItems);
  }

  void _onLoadItems(
    LoadItemsEvent event,
    Emitter<ItemState> emit,
  ) async {
    final response = await _itemLoadItems.call(NoParams());

    response.fold(
      (failure) => emit(ItemLoadFailureState(message: failure.message)),
      (items) => emit(ItemLoadedState(items: items)),
    );
  }

  void _onRefreshItems(
    RefreshItemsEvent event,
    Emitter<ItemState> emit,
  ) async {
    final response = await _itemLoadItems.call(NoParams());

    response.fold(
      (failure) => emit(ItemLoadFailureState(message: failure.message)),
      (items) => emit(ItemLoadedState(items: items)),
    );
  }

  void _onLoadMoreItems(
    LoadMoreItemsEvent event,
    Emitter<ItemState> emit,
  ) async {
    final currentState = state;

    if (currentState is ItemLoadedState && !currentState.hasReachedMax) {
      final response = await _itemLoadMoreItems.call(
        ItemLoadMoreItemsParams(
          offset: event.offset,
        ),
      );

      response.fold(
        (failure) => emit(ItemLoadFailureState(message: failure.message)),
        (items) => _loadMore(items, emit, currentState),
      );
    }
  }

  void _loadMore(
      List<Food> items, Emitter<ItemState> emit, ItemLoadedState currentState) {
    if (items.isEmpty) {
      emit(currentState.copyWith(hasReachedMax: true));
    } else {
      emit(ItemLoadedState(
        items: currentState.items + items,
      ));
    }
  }
}

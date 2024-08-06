import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_test/core/common/usecase/usecase.dart';
import 'package:mobile_test/features/home/domain/entities/food.dart';
import 'package:mobile_test/features/home/domain/usecases/item_load_items.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemLoadItems _itemLoadItems;

  ItemBloc({
    required ItemLoadItems itemLoadItems,
  })  : _itemLoadItems = itemLoadItems,
        super(ItemInitial()) {
    on<ItemEvent>((_, emit) {
      emit(ItemLoadingState());
    });
    on<LoadItemsEvent>(_onLoadItems);
    on<RefreshItemsEvent>(_onRefreshItems);
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
}

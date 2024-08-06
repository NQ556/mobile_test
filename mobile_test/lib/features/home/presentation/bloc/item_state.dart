// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final List<Food> items;
  final bool hasReachedMax;

  ItemLoadedState({
    required this.items,
    this.hasReachedMax = false,
  });

  ItemLoadedState copyWith({
    List<Food>? items,
    bool? hasReachedMax,
  }) {
    return ItemLoadedState(
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

final class ItemLoadFailureState extends ItemState {
  final String message;
  ItemLoadFailureState({required this.message});
}

part of 'item_bloc.dart';

@immutable
sealed class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoadingState extends ItemState {}

final class ItemLoadedState extends ItemState {
  final List<Food> items;
  ItemLoadedState({required this.items});
}

final class ItemLoadFailureState extends ItemState {
  final String message;
  ItemLoadFailureState({required this.message});
}

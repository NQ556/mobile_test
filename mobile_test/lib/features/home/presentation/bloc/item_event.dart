part of 'item_bloc.dart';

@immutable
sealed class ItemEvent {}

class LoadItemsEvent extends ItemEvent {}

class RefreshItemsEvent extends ItemEvent {}

class LoadMoreItemsEvent extends ItemEvent {
  final int offset;
  LoadMoreItemsEvent({required this.offset});
}

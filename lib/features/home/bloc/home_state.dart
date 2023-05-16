part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class ItemEmptyState extends HomeState {}

class ItemInitialState extends HomeState {}

class ItemAddLoadingState extends HomeState {}

class ItemRemoveLoadingState extends HomeState {}

class ItemAddState extends HomeState {
  ItemAddState(this.items);
  final List<String> items;
}

class ItemRemoveState extends HomeState {
  ItemRemoveState(this.items);
  final List<String> items;
}

class ItemErrorState extends HomeState {
  ItemErrorState(this.message);
  final String message;
}

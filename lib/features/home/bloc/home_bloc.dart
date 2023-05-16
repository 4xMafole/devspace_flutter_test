import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devspace_test/repository/repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required DataRepository repository})
      : _repository = repository,
        super(ItemEmptyState()) {
    on<AddItemEvent>(_onAddItemEvent);
    on<RemoveItemEvent>(_onRemoveItemEvent);
  }

  final DataRepository _repository;
  List<String> items = [];

  Future<void> _onAddItemEvent(
    AddItemEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ItemAddLoadingState());
    try {
      final newData = await _repository.fetchItem();
      items.add(newData);
      emit(ItemAddState(items));
    } catch (e) {
      emit(ItemErrorState('Failure to fetch data'));
      emit(ItemAddState(items));
    }
  }

  Future<void> _onRemoveItemEvent(
    RemoveItemEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(ItemRemoveLoadingState());
    try {
      if (items.isNotEmpty) items.removeLast();
      emit(items.isEmpty ? ItemEmptyState() : ItemRemoveState(items));
    } catch (e) {
      emit(ItemErrorState('Failure to remove data'));
    }
  }
}

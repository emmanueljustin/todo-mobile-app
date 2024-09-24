import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'multi_selector_state.dart';

class MultiSelectorCubit extends Cubit<MultiSelectorState> {
  MultiSelectorCubit() : super(const MultiSelectorState());

  void enableMultiSelect() {
    emit(state.copyWith(selectEnabled: true));
  }

  void disableMultiSelect() {
    emit(state.copyWith(selectEnabled: false, selectedItems: const []));
  }

  void onSelect(int id) {
    final List<int> idHolder = [...state.selectedItems];

    bool doesExist = idHolder.contains(id);

    if (!doesExist) {
      idHolder.add(id);
    }

    if (doesExist) {
      idHolder.remove(id);
    }

    emit(state.copyWith(selectedItems: idHolder));
  }
}

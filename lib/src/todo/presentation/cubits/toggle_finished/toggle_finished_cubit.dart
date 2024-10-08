import 'package:bloc/bloc.dart';

class ToggleFinishedCubit extends Cubit<bool> {
  ToggleFinishedCubit() : super(false);

  void onSetDefault(bool value) {
    emit(value);
  }

  void onToggle(bool value) {
    emit(!value);
  }
}

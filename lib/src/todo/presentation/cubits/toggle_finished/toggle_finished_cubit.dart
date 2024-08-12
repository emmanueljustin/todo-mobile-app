import 'package:bloc/bloc.dart';

class ToggleFinishedCubit extends Cubit<bool> {
  ToggleFinishedCubit() : super(false);

  void onToggle(bool value) {
    emit(!value);
  }
}

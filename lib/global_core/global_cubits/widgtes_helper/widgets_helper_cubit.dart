import 'package:bloc/bloc.dart';

class WidgetsHelperCubit<T> extends Cubit<T> {
  WidgetsHelperCubit(super.initialState);

  void onUpdateState(T params) {
    emit(params);
  }
}

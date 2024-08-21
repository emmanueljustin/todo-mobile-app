import 'package:todoapp/global_core/hive_service/hive_boxes.dart';
import 'package:todoapp/src/authentication/data/models/login_Data_model.dart';

class HiveMethods {
  final HiveBoxes _hiveBoxes = HiveBoxes();

  Future<void> setUserData(LoginDataModel? data) async {
    await _hiveBoxes.userBox.put('usr_data', data);
  }

  LoginDataModel? getUserData() {
    return _hiveBoxes.userBox.get('usr_data');
  }
}
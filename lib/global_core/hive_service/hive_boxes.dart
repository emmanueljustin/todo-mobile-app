import 'package:hive/hive.dart';
import 'package:todoapp/global_core/hive_service/hive_adapters/login_data_adapter.dart';
import 'package:todoapp/global_core/hive_service/hive_adapters/user_data_adapter.dart';

class HiveBoxes {
  Box? _userBox;
  
  Box get userBox => _userBox ?? Hive.box('user_token');

  Future<void> registerAdapters() async {
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(LoginDataAdapter());

    await openBoxes();
  }

  Future<void> openBoxes() async {
    _userBox = await Hive.openBox('user_token');
  }
}
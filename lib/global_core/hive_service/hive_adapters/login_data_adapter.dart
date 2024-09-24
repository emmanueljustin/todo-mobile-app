import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';

class LoginDataAdapter extends TypeAdapter<LoginDataModel> {

  @override
  final int typeId = 1;
  
  @override
  LoginDataModel read(BinaryReader reader) {
    return LoginDataModel(
      userToken: reader.read(),
      userData: reader.read()
    );
  }

  @override
  void write(BinaryWriter writer, LoginDataModel obj) {
    writer.write(obj.userToken);
    writer.write(obj.userData);
  }
}
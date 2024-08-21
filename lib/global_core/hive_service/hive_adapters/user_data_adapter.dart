import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/src/authentication/data/models/user_data_model.dart';

class UserDataAdapter extends TypeAdapter<UserDataModel> {
  
  @override
  final int typeId = 0;

  @override
  UserDataModel read(BinaryReader reader) {
    return UserDataModel(
      id: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
      name: reader.read(),
      email: reader.read()
    );
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer.write(obj.id);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
    writer.write(obj.name);
    writer.write(obj.email);
  }

}
import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String email;

  const UserData({
    this.id = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.name = '',
    this.email = ''
  });

  @override
  List<Object> get props => [
    id,
    createdAt,
    updatedAt,
    name,
    email
  ];
}
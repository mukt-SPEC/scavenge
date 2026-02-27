import 'package:scavenge/model/user.dart';

sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String error;
  UserFailure({required this.error});
}

class UserSuccess extends UserState {
  final UserModel? user;
  UserSuccess({required this.user});
}
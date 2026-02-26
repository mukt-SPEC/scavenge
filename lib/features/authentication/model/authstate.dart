// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:scavenge/model/random.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

class AuthSuccess extends AuthState {
  final User? user;
  AuthSuccess({this.user});
}

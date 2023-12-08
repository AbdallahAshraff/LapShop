


import 'package:ecommerceapp/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {

   final UserModel userModel;
  LoginSuccess(this.userModel);
}

class LoginFailed extends LoginState {}

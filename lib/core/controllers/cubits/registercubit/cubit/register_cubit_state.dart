import 'package:ecommerceapp/models/user_model.dart';

abstract class RegisterCubitState {}

class RegisterInitial extends RegisterCubitState {}

class RegisterLoading extends RegisterCubitState {}

class RegisterSuccess extends RegisterCubitState {
  final UserModel userModel;
  RegisterSuccess(this.userModel);
}

class RegisterFailed extends RegisterCubitState {}

class ChooseImage extends RegisterCubitState {}

import 'package:ecommerceapp/core/controllers/cubits/login/cubit/login_state.dart';
import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void loginUser({required email, required password}) {
    emit(LoginLoading());
    DioHelperStore.postData(url: ApiConstants.loginUrl, data: {
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name);
      emit(LoginSuccess(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginFailed());
    });
  }
}

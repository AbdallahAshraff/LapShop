import 'dart:convert';

import 'dart:io';

import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  

  void registerUser(
      {required name,
      required email,
      required phone,
      required nationalId,
      required password}) {
    emit(RegisterLoading());
    DioHelperStore.postData(url: ApiConstants.registerUrl, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'nationalId': nationalId,
      'gender': 'male',
      'password': password,
      'profileImage': userImage
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name);
      emit(RegisterSuccess(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(RegisterFailed());
    });
  }

 
  ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;

  Future<void> addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      print('images = $userImage');
      emit(ChooseImage());
    } else {
      print('no image selected');
    }
  }
}

import 'package:ecommerceapp/core/controllers/cubits/profile/cubit/profile_state.dart';
import 'package:ecommerceapp/core/managers/constants.dart';
import 'package:ecommerceapp/core/managers/values.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel? profile;
  void getProfileInfo() {
    emit(GetProfileLoading());
    DioHelperStore.postData(
        url: ApiConstants.profileApi, data: {'token': token}).then((value) {
      profile = UserModel.fromJson(value.data);
      emit(GetProfileSuccess());
      print(profile!.user!.name);
    }).catchError((onError) {
      emit(GetProfileFailed());
      print(onError.toString());
    });
  }

  Future<void> updateProfile({String? name, String? email, String? phoneNumber}) {
    emit(UpdateProfileLoading());
   return DioHelperStore.putData(url: ApiConstants.updateProfileApi, data: {
      "name": name,
      "email": email,
      "phone": phoneNumber,
      "nationalId":natoinalId,
      "gender": "male",
      "password": "Bedom10!",
      "token": token
    }).then((value) {
      profile = UserModel.fromJson(value.data);
      getProfileInfo();
      emit(UpdateProfileSuccess());
      print(profile!.message);
    }).catchError((onError) {
      emit(UpdateProfileFailed());
      print(onError.toString());
    });
  }
}

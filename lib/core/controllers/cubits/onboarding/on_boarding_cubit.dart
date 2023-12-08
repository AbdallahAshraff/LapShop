import 'dart:developer';

import 'package:ecommerceapp/core/controllers/cubits/onboarding/on_boarding_state.dart';
import 'package:ecommerceapp/core/managers/nav.dart';
import 'package:ecommerceapp/core/network/local/cache_helper.dart';
import 'package:ecommerceapp/screens/modules/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(OnBoardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);
  bool isPagelast = false;
  int screenIndex = 0;
  void isLast(index) {
    isPagelast = true;
    screenIndex = index;
    log("$screenIndex");
    emit(LastPageState());
  }

  void isNotLast(index) {
    isPagelast = false;
    screenIndex = index;
    log("$screenIndex");
    emit(NotLastPageState());
  }

  void submit(context) {
    CacheHelper.saveData(key: 'Boarding', value: true).then((value) {
      navigateToNextScreen(context, LoginScreen());
    });
  }
}

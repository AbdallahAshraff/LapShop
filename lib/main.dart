import 'dart:developer';

import 'package:ecommerceapp/core/controllers/cubits/login/cubit/login_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/onboarding/on_boarding_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/products/cubit/product_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/registercubit/cubit/register_cubit_cubit.dart';
import 'package:ecommerceapp/core/controllers/observer/bloc_observer.dart';
import 'package:ecommerceapp/core/managers/themes.dart';
import 'package:ecommerceapp/core/managers/values.dart';
import 'package:ecommerceapp/core/network/local/cache_helper.dart';
import 'package:ecommerceapp/core/network/remote/dio_helper.dart';
import 'package:ecommerceapp/screens/modules/login.dart';
import 'package:ecommerceapp/screens/modules/on_boarding.dart';
import 'package:ecommerceapp/screens/modules/prod_screen.dart';
import 'package:ecommerceapp/screens/modules/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  Bloc.observer = MyBlocObserver();
  Boarding = CacheHelper.getData(key: 'Boarding');
  token = CacheHelper.getData(key: 'token');
  natoinalId = CacheHelper.getData(key: 'userId');
  loggedIn = CacheHelper.getData(key: 'isLoggedIn');
  print(Boarding);
  print(token);
  print(natoinalId);
  print(loggedIn);
  if (Boarding) {
    if (loggedIn) {
      nextScreen = ProductScreen();
    } else {
      nextScreen = LoginScreen();
    }
  } else {
    nextScreen = const OnBoardingScreen();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
          lazy: true,
        ),
         BlocProvider(
          create: (context) => ProductCubit()..getHomeProducts(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: nextScreen,
      ),
    );
  }
}

import 'dart:developer';

import 'package:ecommerceapp/core/controllers/cubits/login/cubit/login_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/login/cubit/login_state.dart';
import 'package:ecommerceapp/core/managers/nav.dart';
import 'package:ecommerceapp/core/network/local/cache_helper.dart';
import 'package:ecommerceapp/screens/modules/prod_screen.dart';
import 'package:ecommerceapp/screens/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.userModel.status == "success") {
            CacheHelper.putBoolData(key: 'isLoggedIn', value: true);
            navigateAndFinishThisScreen(context, ProductScreen());
          } else {
            log(state.userModel.message!);
          }
          isLoading = false;
        } else if (state is LoginLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            // appBar: AppBar(),
            body: Stack(
              children: [
                Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email Address',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                              height: 60,
                              color: Colors.black,
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  cubit.loginUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account ? "),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

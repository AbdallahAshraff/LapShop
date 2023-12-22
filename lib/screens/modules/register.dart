import 'dart:developer';

import 'package:ecommerceapp/core/controllers/cubits/registercubit/cubit/register_cubit_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/registercubit/cubit/register_cubit_state.dart';
import 'package:ecommerceapp/screens/modules/login.dart';
import 'package:ecommerceapp/screens/widgets/botton.dart';

import 'package:ecommerceapp/screens/widgets/custom_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/nav.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterCubitState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          if (state.userModel.status == "success") {
            log(state.userModel.message!);
            //showToast(state.userModel.message!, ToastStates.SUCCESS);
            log(state.userModel.user!.token!);
            CacheHelper.saveData(
              key: 'userId',
              value: state.userModel.user!.nationalId,
            ).then((value) {
              natoinalId = state.userModel.user!.nationalId;
              navigateAndFinishThisScreen(
                context,
                LoginScreen(),
              );
            });
          } else {
            log(state.userModel.message!);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Register'),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cubit.image == null
                          ? MaterialButton(
                              onPressed: () {
                                cubit.addImage();
                              },
                              child: Center(
                                child: CircleAvatar(
                                  radius: 60,
                                  child: ClipOval(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://www.bing.com/th?id=OIP.UL-1DMfhVszKjcYlgEespAD0D_&w=159&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: CircleAvatar(
                                radius: 60,
                                child: ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(cubit.image!),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        hintText: 'Full Name',
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email Address',
                        icon: Icons.email,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                        icon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Password',
                        icon: Icons.password,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: nationalController,
                        keyboardType: TextInputType.number,
                        hintText: 'National ID',
                        icon: Icons.video_stable,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          color: Colors.black,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.registerUser(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                nationalId: nationalController.text,
                              );
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

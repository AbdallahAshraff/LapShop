
import 'dart:developer';

import 'package:ecommerceapp/core/controllers/cubits/registercubit/cubit/register_cubit_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/registercubit/cubit/register_cubit_state.dart';
import 'package:ecommerceapp/screens/modules/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/nav.dart';
import '../../core/managers/values.dart';
import '../../core/network/local/cache_helper.dart';
import '../widgets/botton.dart';
import '../widgets/text_form.dart';

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
              key: 'userId', value: state.userModel.user!.nationalId)
              .then((value) {
            natoinalId = state.userModel.user!.nationalId;
          });
          CacheHelper.saveData(
            key: 'token',
            value: state.userModel.user!.token,
          ).then((value) {
            token = state.userModel.user!.token!;
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
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 100),
                    child: cubit.image == null
                        ? MaterialButton(
                            onPressed: () {
                              cubit.addImage();
                            },
                            child: CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://www.bing.com/th?id=OIP.UL-1DMfhVszKjcYlgEespAD0D_&w=159&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )))
                        : CircleAvatar(
                            radius: 40,
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
                    SizedBox(
                  height: 10,
                ),
                DefaultFieldForm(
                  controller: nameController,
                  keyboard: TextInputType.text,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                  labelStyle:const TextStyle(color:Colors.black),
                  label: 'Full Name',
                  prefix: Icons.person,
                  hint: 'Full Name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  labelStyle: const TextStyle(color:Colors.black),
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter your Email';
                    }
                    return null;
                  },
                  label: 'Email Address',
                  prefix: Icons.email,
                  hint: 'Email Address',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  labelStyle:  TextStyle(color:Colors.black),
                  controller: phoneController,
                  keyboard: TextInputType.phone,
                  label: 'Phone',
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Phone';
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  hint: 'Phone',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                    labelStyle: const TextStyle(color:Colors.black),
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    valid: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter Your Password';
                      }
                      return null;
                    },
                    label: 'Password',
                    prefix: Icons.password,
                    hint: 'Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                DefaultFieldForm(
                  labelStyle: const TextStyle(color:Colors.black),
                  controller: nationalController,
                  keyboard: TextInputType.number,
                  label: 'National ID',
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Confirm Your National Id';
                    }
                    return null;
                  },
                  prefix: Icons.video_stable,
                  hint: 'National ID',
                  hintStyle: const TextStyle(color: Colors.grey),
                  show: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                  DefaultButton(
                    backgroundColor:Colors.black,
                    borderColor: Colors.transparent,
                    buttonWidget: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    function: () {
                      if (formKey.currentState!.validate()) {
                                cubit.registerUser(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  nationalId: nationalController.text,
                                );
                              }
                    }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

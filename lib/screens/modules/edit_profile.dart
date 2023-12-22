import 'package:ecommerceapp/core/controllers/cubits/profile/cubit/profile_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/profile/cubit/profile_state.dart';
import 'package:ecommerceapp/core/methods/show_snack_bar.dart';
import 'package:ecommerceapp/screens/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(listener: (context, state) {
      if (state is UpdateProfileLoading) {
        isLoading = true;
      } else {
        isLoading = false;
      }
    }, builder: (context, state) {
      var cubit = ProfileCubit.get(context);
      var nameController = TextEditingController();
      var emailController = TextEditingController();
      var phoneController = TextEditingController();

      nameController.text = cubit.profile!.user!.name!;
      emailController.text = cubit.profile!.user!.email!;
      phoneController.text = cubit.profile!.user!.phone!;
      GlobalKey<FormState> formkey = GlobalKey();

      return ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            title: Text('Edit Profile'),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: CircleAvatar(
                          radius: 68,
                          backgroundImage: cubit.profile!.user!.profileImage ==
                                  null
                              ? const NetworkImage(
                                  'https://www.bing.com/th?id=OIP.UL-1DMfhVszKjcYlgEespAD0D_&w=159&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2')
                              : NetworkImage(
                                  cubit.profile!.user!.profileImage!)),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: CustomTextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        icon: Icons.person,
                        hintText: 'Name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: CustomTextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        icon: Icons.phone,
                        hintText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 20),
                      child: MaterialButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          height: 60,
                          color: HexColor('#07094D'),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await cubit
                                  .updateProfile(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phoneNumber: phoneController.text)
                                  .then((value) {
                                showSnackBar(
                                    context, 'Profile has been Updated');
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

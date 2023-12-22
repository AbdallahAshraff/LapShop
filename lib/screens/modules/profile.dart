import 'package:ecommerceapp/core/controllers/cubits/profile/cubit/profile_cubit.dart';
import 'package:ecommerceapp/core/controllers/cubits/profile/cubit/profile_state.dart';
import 'package:ecommerceapp/core/managers/nav.dart';
import 'package:ecommerceapp/screens/modules/edit_profile.dart';
import 'package:ecommerceapp/screens/widgets/build_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        
        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.grey[200],
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  CircleAvatar(
                    radius: 75,
                    backgroundImage: cubit.profile!.user!.profileImage == null
                        ? const NetworkImage(
                            'https://www.bing.com/th?id=OIP.UL-1DMfhVszKjcYlgEespAD0D_&w=159&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2')
                        : NetworkImage(cubit.profile!.user!.profileImage!),
                  ),
                  const SizedBox(height: 20),
                  buildProfileInfo('Name', cubit.profile!.user!.name),
                  buildProfileInfo('Email', cubit.profile!.user!.email),
                  buildProfileInfo('Phone', cubit.profile!.user!.phone),
                buildProfileInfo('Gender', cubit.profile!.user!.gender),
                

                  const SizedBox(height: 40),
                 ElevatedButton(
                      onPressed: () {
                        navigateToNextScreen(context, EditProfile());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor('#07094D'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3.0,
                        minimumSize: const Size(200, 60),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                 ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

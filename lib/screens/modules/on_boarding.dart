import 'package:ecommerceapp/core/controllers/cubits/onboarding/on_boarding_state.dart';
import 'package:ecommerceapp/core/managers/lists.dart';

import 'package:ecommerceapp/screens/widgets/botton.dart';
import 'package:ecommerceapp/screens/widgets/build_onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/controllers/cubits/onboarding/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var onBoardingController = PageController();
    OnboardingCubit cubit = OnboardingCubit.get(context);

    return BlocConsumer<OnboardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: PageView.builder(
                  onPageChanged: (index) {
                    index == onboardingList.length - 1
                        ? cubit.isLast(index)
                        : cubit.isNotLast(index);
                  },
                  controller: onBoardingController,
                  itemCount: onboardingList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildOnBoardingItem(onboardingList[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: cubit.isPagelast
                    ? DefaultButton(
                        buttonWidget: const Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        function: () {
                          cubit.submit(context);
                        },
                      )
                    : DefaultButton(
                        buttonWidget: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        function: () {
                          onBoardingController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

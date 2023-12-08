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
          appBar: AppBar(title: const Text('Onboarding')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'pixel',
                style: TextStyle(fontSize: 26),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 450,
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
              const SizedBox(
                height: 10,
              ),
              cubit.isPagelast
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultButton(
                        buttonWidget: const Text('Get Started',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        function: () {
                          cubit.submit(context);
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultButton(
                        buttonWidget: const Text('Next',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        function: () {
                          onBoardingController.nextPage(
                              duration: const Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}

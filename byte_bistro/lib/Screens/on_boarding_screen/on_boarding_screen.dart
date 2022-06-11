// OnboardingScreen
import 'package:byte_bistro/Screens/on_boarding_screen/on_boarding_ui.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          itemBuilder: (context, index) {
            return OnBoardingUi();
          },
        ),
      ),
    );
  }
}

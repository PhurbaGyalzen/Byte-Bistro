import 'package:byte_bistro/Screens/on_boarding_screen/on_boarding_info.dart';
import 'package:byte_bistro/controller/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  OnBoardingController onBoardingController = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          PageView.builder(
            itemBuilder: ((context, index) {
              return OnboardingInfo(
                  image: onBoardingController.onBoardingPages[index].image,
                  title: onBoardingController.onBoardingPages[index].title,
                  description:
                      onBoardingController.onBoardingPages[index].description);
            }),
            itemCount: onBoardingController.onBoardingPages.length,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              children: List.generate(
                onBoardingController.onBoardingPages.length,
                (index) => Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: onBoardingController.selectedIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

import 'package:byte_bistro/Screens/on_boarding_screen/on_boarding_info.dart';
import 'package:byte_bistro/constants/colors.dart';
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
            controller: onBoardingController.pageController,
            onPageChanged: onBoardingController.selectedIndex,
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
                (index) => Obx(() {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: onBoardingController.selectedIndex.value == index
                          ? kTextColor
                          : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Obx(() {
                  return Text(
                      onBoardingController.selectedIndex.value ==
                              onBoardingController.onBoardingPages.length - 1
                          ? "Start"
                          : "Next",
                      style: Theme.of(context).textTheme.headline2);
                }),
                onPressed: () {
                  if (onBoardingController.selectedIndex.value ==
                      onBoardingController.onBoardingPages.length - 1) {
                    Get.offNamed('home');
                  } else {
                    onBoardingController.forwardAction;
                  }
                }),
          )
        ],
      )),
    );
  }
}

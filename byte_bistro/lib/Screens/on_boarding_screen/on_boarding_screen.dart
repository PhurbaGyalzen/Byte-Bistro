import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());

  List data = [
    {
      "image": "assets/images/esewa.json",
      "title": "Qr Code Order",
      "description":
          "Customers read a QR Code from their table and order food & drink from their phones."
    },
    {
      "image": "assets/images/food.json",
      "title": "Healthy & Delicious Food",
      "description":
          "Tuck into healthy recipes that you can make in under 30 minutes. We've got plenty of quick and tasty salads, soups and mains to leave you feeling nourished."
    },
    {
      "image": "assets/images/qrCode.json",
      "title": "Pay with Esewa",
      "description": "You can pay for your ordered food online using eSewa."
    },
  ];

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
              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          // child: Image(
                          //   image: AssetImage(image),
                          //   width: MediaQuery.of(context).size.width - 100,
                          //   height: MediaQuery.of(context).size.height - 370,
                          //   fit: BoxFit.cover,
                          // ),

                          child: Container(
                            height: 400,
                            child: Lottie.asset(
                              data[index]['image'],
                              height: 300,
                              width: 300,
                              animate: true,
                              repeat: true,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(data[index]['title'].toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            wordSpacing: 0.3,
                            height: 1.5,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Text(
                          data[index]['description'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.1,
                            wordSpacing: 0.5,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
              // return OnboardingInfo(
              //     image: onBoardingController.onBoardingPages[index].image,
              //     title: onBoardingController.onBoardingPages[index].title,
              //     description:
              //         onBoardingController.onBoardingPages[index].description);
            }),
            itemCount: data.length,
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
                    onBoardingController.forwardAction();
                  }
                }),
          )
        ],
      )),
    );
  }
}

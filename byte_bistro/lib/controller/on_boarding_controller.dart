import 'package:get/get.dart';

import '../Models/on_boarding.dart';

class OnBoardingController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  List<OnBoarding> onBoardingPages = [
    OnBoarding(
      image: 'assets/images/buffMomo.jpg',
      title: 'Momo',
      description: 'mitho xa',
    ),
    OnBoarding(
      image: 'assets/images/buffMomo.jpg',
      title: 'Chowmein',
      description: 'mitho xa',
    ),
    OnBoarding(
      image: 'assets/images/buffMomo.jpg',
      title: 'Burger',
      description: 'mitho xa',
    ),
  ];
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../constants/colors.dart';

class OrderSucess extends StatelessWidget {
  const OrderSucess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Lottie.asset(
                      'assets/images/lottieOrder.json',
                      height: 50,
                      width: 50,
                      animate: true,
                      repeat: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 40,
                    ),
                    child: Text(
                      'Your order is sent successfully!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        height: 1.5,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Estimated Time ',
                        style: TextStyle(color: kTextLightColor),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SlideCountdown(
                        durationTitle: DurationTitle.enShort(),
                        decoration: BoxDecoration(
                            color: kTextColor,
                            borderRadius: BorderRadius.circular(15)),
                        duration: const Duration(
                          hours: 0,
                          minutes: 30,
                        ),
                        // separatorType: SeparatorType.title,
                        slideDirection: SlideDirection.up,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    left: 40,
                    bottom: 20,
                  ),
                  child: TextField(
                    cursorColor: kPrimary,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hoverColor: kPrimary,
                      hintText: 'Feedback ....',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kTextColor),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 40, bottom: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimary,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(230, 50),
                      ),

                      child: Text(
                        'SEND FEEDBACK',
                        style: TextStyle(
                          color: kTextColor,
                          letterSpacing: 0.5,
                        ),
                      ),

                      onPressed: () {},
                      // style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all(kPrimary)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

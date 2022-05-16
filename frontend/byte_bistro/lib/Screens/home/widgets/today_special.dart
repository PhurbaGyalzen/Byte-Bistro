import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class TodaySpecial extends StatelessWidget {
  const TodaySpecial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Todays Special',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.5,
              color: kTextColor,
            ),
          ),
          SizedBox(
            height: 250.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: ((context, index) => Container(
                    width: 355,
                    margin: EdgeInsets.only(
                      top: 20,
                      left: 0,
                      right: 20,
                      bottom: 8,
                    ),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                          color: Color(0xFFB0CCE1).withOpacity(0.32),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Egg Salad',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            height: 1.3,
                            letterSpacing: 0.5,
                            color: kTextColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Egg rolls are a variety of deep-fried appetizers served in American Chinese restaurants.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5,
                                  color: kTextLightColor,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/foodlogo.png')))
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

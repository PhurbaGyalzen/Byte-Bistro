import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class FoodTab extends StatelessWidget {
  final tabIcon = [
    'momo.png',
    'noodles.png',
    'hamburger.png',
    'flatpizza.png',
    'coffee.png',
    'beer.png',
    'view.png',
  ];

  final tabText = [
    'Momo',
    'Noodles',
    'Burger',
    'Pizza',
    'Cock',
    'Beer',
    'All',
  ];
  FoodTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 8),
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              height: 1.5,
              color: kTextColor,
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabIcon.length,
              itemBuilder: ((context, index) => Container(
                    width: 115,
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    margin: EdgeInsets.only(
                      right: 16,
                      bottom: 5,
                      top: 10,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                          color: Color(0xFFB0CCE1).withOpacity(0.32),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image(
                            image:
                                AssetImage('assets/images/${tabIcon[index]}'),
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Text('${tabText[index]}',
                            style: TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: kTextColor)),
                        SizedBox(width: 8),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

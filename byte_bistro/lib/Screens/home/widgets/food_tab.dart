import 'package:byte_bistro/Screens/Category_momo.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class FoodTab extends StatefulWidget {
  const FoodTab({Key? key}) : super(key: key);

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  // ignore: prefer_typing_uninitialized_variables
  var catName;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories', style: Theme.of(context).textTheme.headline1),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tabIcon.length,
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        catName = tabText[index];
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MOMO(
                              catName: catName,
                            ),
                          ));
                    },
                    child: Container(
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
                          Text(
                            tabText[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:byte_bistro/Screens/Category_momo.dart';
import 'package:flutter/material.dart';

class FoodTab extends StatelessWidget {
  FoodTab({Key? key}) : super(key: key);

  var catName;

  final tabItems = [
    {
      "tabName": "Momo",
      "tabIcon": "assets/images/momo.png",
    },
    {
      "tabName": "Noodles",
      "tabIcon": "assets/images/noodles.png",
    },
    {
      "tabName": "Burger",
      "tabIcon": "assets/images/hamburger.png",
    },
    {
      "tabName": "Pizza",
      "tabIcon": "assets/images/flatpizza.png",
    },
    {
      "tabName": "Coffee",
      "tabIcon": "assets/images/coffee.png",
    },
    {
      "tabName": "Beer",
      "tabIcon": "assets/images/beer.png",
    },
    {
      "tabName": "All",
      "tabIcon": "assets/images/view.png",
    },
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
              itemCount: tabItems.length,
              itemBuilder: ((context, index) => GestureDetector(
                    // onTap: () {
                    //   setState(
                    //     () {
                    //       catName = tabText[index];
                    //     },
                    //   );

                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MOMO(
                    //         catName: catName,
                    //       ),
                    //     ),
                    //   );
                    // },
                    onTap: () {},
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
                              image: AssetImage(
                                  tabItems[index]["tabIcon"].toString()),
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Text(
                            tabItems[index]["tabName"].toString(),
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

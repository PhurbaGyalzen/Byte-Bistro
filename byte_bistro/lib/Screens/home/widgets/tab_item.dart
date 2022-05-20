import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  const TabItem({Key? key}) : super(key: key);

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  // final foodData = getFoodData();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: ((context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/individual');
              },
              child: Container(
                width: 170,
                margin: EdgeInsets.only(
                  top: 60,
                  left: 0,
                  right: 18,
                  bottom: 8,
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                      color: Color(0xFFB0CCE1).withOpacity(0.32),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: -59,
                        left: 20,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(80),
                              border:
                                  Border.all(color: Colors.white30, width: 3)),
                        )),
                    Positioned(
                      top: -80,
                      left: 0,
                      child: Image(
                        image: AssetImage('assets/images/foodlogo.png'),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Positioned(
                      top: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'momo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              letterSpacing: 0.5,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Healthy and delicious',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                              color: kTextLightColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Row(
                        children: const [
                          Text('Rs 500',
                              style: TextStyle(fontWeight: FontWeight.w200)),
                          SizedBox(width: 50),
                          Image(
                              image: AssetImage('assets/images/like.png'),
                              height: 20,
                              width: 20)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

import 'package:byte_bistro/constants/colors.dart';
import 'package:flutter/material.dart';

class TopOfDay extends StatelessWidget {
  const TopOfDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top of the day',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: 310.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: ((context, index) => Container(
                    width: 170,
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 0,
                      right: 18,
                      bottom: 8,
                    ),
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      bottom: 0,
                      top: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                          color: Color(0xFFB0CCE1).withOpacity(0.32),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image(
                            image: AssetImage('assets/images/momo.jpg'),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Dumpling Momo',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hot & Spicy',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
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

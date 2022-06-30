import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({Key? key}) : super(key: key);

  var data = [
    {
      "title": "Privacy Policy",
      "description":
          "Byte Bistro operates the ‘Byte Bistro’ app (both in Google Play Store and Apple App Store) and its website www.Byte Bistro.com . This page is used to inform users who have decided to use our app regarding policies with the collection, use and disclosure of Personal Information. If you choose to use our App 'Byte Bistro', then you agree to the collection and use of information as mentioned in this policy. The personal information that our app collects are solely used for providing service to its users. The information collected will not be used or shared with any party except as described in this policy.",
    },
    {
      "title": "Information Collection and Usage",
      "description":
          "Our App requires you to provide us with information for personal identification including but not limited to your name, email address, contact number, postal address and photo (optional). As for our delivery riders, we collect the above mentioned information with additional details of their driving license (in form of image) and number. The rider’s location is tracked when they are on their way to deliver the goods. The information that we collect are used to contact and identify you and process the orders placed with the participating vendors. The information is shared as needed to process the orders and deliver the orders to you. Users’ email address may be used to convey occasional newsletters, special offers and updates about new vendors as well as our service.",
    },
    {
      "title": "Log Data",
      "description":
          "We want to inform you that we collect the Log Data which may include the date and time when you access our app."
    },
    {
      "title": "Security",
      "description":
          "We value our users trust in providing us their Personal Information and we ensure you that we take all the acceptable means of protecting the information provided to us. But as no method of transmission of data over the Internet or electronic storage is 100% secure and reliable, we cannot guarantee that the information will be secure completely."
    },
    {
      "title": "Service Providers",
      "description":
          "In order to facilitate our work and services, we may employ third-party companies. We have used online payment services in Nepal in order to make it easy for our users to make payments online. We would like to inform our users that we may need to give access to your personal information to these companies. The purpose of giving these third parties ability to access you personal information is to perform the tasks assigned to them. However, these companies are obligated not to use and disclose any of the information for any other purpose."
    },
    {
      "title": "Third Party Links",
      "description":
          "Our website may contain links to other websites or apps. When you click on a third-party link, you will be directed to that website or app. As we do not operate or own any other external websites or apps, we advise you to review their Privacy Policy. We do not have any control or responsibility for the services, content, practices and privacy policy of any other third-party links."
    },
    {
      "title": "Privacy Policy Updates",
      "description":
          "The Privacy Policy may be updated from time to time without prior notice. As the revised policy is effective immediately when posted, our users are advised to review the Privacy Policy for any changes periodically. The usage of our app and services acknowledges your acceptance of the updated privacy policy."
    },
    {
      "title": "Contact Us",
      "description":
          "If you have any queries or suggestions regarding our Privacy Policy, please do not hesitate to contact us."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Get.toNamed('/profileScreen')),
            title: Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: kPrimary),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data[index]["title"]}',
                          style: TextStyle(
                              fontSize: 25,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${data[index]["description"]}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  }),
                  itemCount: data.length,
                ),
              ),
            ),
          ),
        ));
  }
}

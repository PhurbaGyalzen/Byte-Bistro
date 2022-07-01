import 'package:byte_bistro/Services/http_service.dart';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/favourite_controller.dart';
import 'package:byte_bistro/controller/logged_user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final FavouriteController favouriteController =
      Get.put(FavouriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () => Get.offAllNamed('/home')),
            title: Text(
              'Favourite',
              style: Theme.of(context).textTheme.headline1,
            ),
            backgroundColor: kPrimary),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 700,
              child: Obx(
                () => ListView.builder(
                  itemCount: favouriteController.favouriteList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 355,
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 5,
                        right: 5,
                        bottom: 8,
                      ),
                      padding: EdgeInsets.all(5),
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
                      child: ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            favouriteController.removeFavorite(
                              favouriteController.favouriteList[index].id,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Removed from Favourite')),
                            );
                          },
                        ),
                        leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                                width: 48,
                                height: 48,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 200.0,
                                  child: Image(
                                      height: 120,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          PersistentHtpp.baseUrl +
                                              favouriteController
                                                  .favouriteList[index]
                                                  .foodId
                                                  .image)),
                                ))),
                        title: Text(favouriteController
                            .favouriteList[index].foodId.name),
                        subtitle: Text('Rs : ' +
                            favouriteController
                                .favouriteList[index].foodId.price
                                .toString()),
                        dense: false,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
    // body: FutureBuilder(
    //   future:
    //       favouriteController.getUserFavourites('627fbfa1d464ffbeb80b985b'),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<Favourite> data = snapshot.data as List<Favourite>;
    //       return ListView.builder(
    //         itemCount: data.length,
    //         itemBuilder: (context, index) {
    //           return ListTile(
    //             leading: GestureDetector(
    //               behavior: HitTestBehavior.translucent,
    //               onTap: () {},
    //               child: Container(
    //                 width: 48,
    //                 height: 48,
    //                 padding: const EdgeInsets.symmetric(vertical: 4.0),
    //                 alignment: Alignment.center,
    //                 child: CircleAvatar(
    //                   radius: 200.0,
    //                   child: Image(
    //                       height: 120,
    //                       fit: BoxFit.cover,
    //                       image: AssetImage(
    //                           'assets/images/' + data[index].foodId.image)),
    //                 ),
    //               ),
    //             ),
    //             title: Text(data[index].foodId.name),
    //             subtitle: Text(data[index].foodId.price.toString()),
    //             trailing: IconButton(
    //               icon: Icon(Icons.delete),
    //               onPressed: () => {},
    //               // onPressed: () {
    //               //   favouriteController.deleteFavourite(data[index].id);
    //               // },
    //             ),
    //           );
    //         },
    //       );
    //     } else {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // ));
  }
}

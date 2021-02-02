import 'package:flutter/material.dart';
import 'package:cinema_vendor_app/constant.dart';
import 'package:cinema_vendor_app/screens/notifications_page.dart';
import 'package:cinema_vendor_app/screens/addmovie.dart';
import 'package:cinema_vendor_app/screens/getmovie.dart';
import 'package:badges/badges.dart';

class AdminHome extends StatefulWidget {
  static String id = 'AdminHome';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '🍿 Dashboard',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 27,
          ),
          onPressed: () {},
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
                  return NotificationsPage();
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge(
                  position: BadgePosition(start: 14, top: 10),
                  badgeColor: Colors.red,
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/popcorn.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AddMovie.id);
                    },
                    child: Card(
                      shadowColor: kBackground,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 30),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '➕ ',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Text(
                                'Add Movie',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, GetMovie.id);
                    },
                    child: Card(
                      elevation: 5.0,
                      shadowColor: kBackground,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 30),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '🎞️',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                'View Movies',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

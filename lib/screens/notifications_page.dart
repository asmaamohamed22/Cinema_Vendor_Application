import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinema_vendor_app/services/store.dart';
import 'package:cinema_vendor_app/screens/movie_details.dart';

class NotificationsPage extends StatefulWidget {
  static String id = 'NotificationsPage';
  NotificationsPage({Key key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadAllNotifications(),
          builder: (context, snapshot) {
            print("--------> " + snapshot.data.docs.length.toString());
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
                        return SingleMoviePage(
                          movieId: snapshot.data.docs[index].data()['movieId'],
                        );
                      }));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black45,
                                  spreadRadius: 0.5,
                                  offset: Offset(3, 4))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 40,
                                backgroundImage: NetworkImage(
                                  '${snapshot.data.docs[index].data()['movieImage']}',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data.docs[index].data()['movieName']}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Available Seats:  ${snapshot.data.docs[index].data()['availableSeats']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      'Booked Seats:  ${snapshot.data.docs[index].data()['allBookedSeats']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                animating: true,
                radius: 14,
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

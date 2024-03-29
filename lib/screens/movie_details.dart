import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinema_vendor_app/services/store.dart';
import 'package:cinema_vendor_app/constant.dart';

class SingleMoviePage extends StatefulWidget {
  static String id = 'SingleMoviePage';
  final String movieId;
  SingleMoviePage({Key key, this.movieId}) : super(key: key);

  @override
  _SingleMoviePageState createState() => _SingleMoviePageState();
}

class _SingleMoviePageState extends State<SingleMoviePage> {
  @override
  void initState() {
    super.initState();
  }

  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Booked Seats',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _store.getSingleMovie(movieId: widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("--->${snapshot.data.data()['movieTitle']}");
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 100,
                            backgroundColor: kBackground,
                            child: CircleAvatar(
                              maxRadius: 95,
                              backgroundImage: NetworkImage(
                                  '${snapshot.data.data()['movieImage']}'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${snapshot.data.data()['movieTitle']}',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.45,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: kBackground),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Available seats: ${snapshot.data.data()['movieNumberSeats']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.44,
                          height: 40,
                          child: FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: kBackground),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: kBackground,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${snapshot.data.data()['movieTime']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: GridView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        childAspectRatio: 1,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: snapshot.data.data()['seats'].length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 2,
                          height: 2,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: () {
                              if (snapshot.data.data()['seats'][index]
                                      ['isReserved'] ==
                                  1) {
                                return Colors.grey;
                              } else if (snapshot.data.data()['seats'][index]
                                      ['isReserved'] ==
                                  0) {
                                return Colors.white;
                              } else {
                                return Colors.green;
                              }
                            }(),
                            border: Border.all(
                              color: Colors.black,
                              width: 1.2,
                            ),
                          ),
                          child: Center(
                              child: Text(
                            '${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ),
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}

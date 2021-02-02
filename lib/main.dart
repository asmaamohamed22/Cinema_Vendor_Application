import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash.dart';
import 'package:cinema_vendor_app/Utils/push_notifications.dart';
import 'package:cinema_vendor_app/screens/addmovie.dart';
import 'package:cinema_vendor_app/screens/admin_home.dart';
import 'package:cinema_vendor_app/screens/editmovie.dart';
import 'package:cinema_vendor_app/screens/getmovie.dart';
import 'package:cinema_vendor_app/screens/movie_details.dart';
import 'package:cinema_vendor_app/screens/notifications_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyVendor());
}

class MyVendor extends StatefulWidget {
  @override
  _MyVendorState createState() => _MyVendorState();
}

class _MyVendorState extends State<MyVendor> {
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    GlobalNotification.instance.notificationSetup(navigatorKey: navKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        primaryColor: Color(0xFFF9A826),
      ),
      navigatorKey: navKey,
      home: Splash(),
      routes: {
        AdminHome.id: (context) => AdminHome(),
        AddMovie.id: (context) => AddMovie(),
        GetMovie.id: (context) => GetMovie(),
        EditMovie.id: (context) => EditMovie(),
        NotificationsPage.id: (context) => NotificationsPage(),
        SingleMoviePage.id: (context) => SingleMoviePage(),
      },
    );
  }
}

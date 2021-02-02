import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cinema_vendor_app/screens/notifications_page.dart';

class GlobalNotification {
  FirebaseMessaging _firebaseMessaging;
  GlobalKey<NavigatorState> navigatorKey;

  static StreamController<Map<String, dynamic>> _onMessageStreamController =
      StreamController.broadcast();
  static StreamController<Map<String, dynamic>> _streamController =
      StreamController.broadcast();

  static GlobalNotification instance = new GlobalNotification._();
  GlobalNotification._();

  static final Stream<Map<String, dynamic>> onFcmMessage =
      _streamController.stream;

  void notificationSetup({GlobalKey<NavigatorState> navigatorKey}) {
    _firebaseMessaging = FirebaseMessaging();
    this.navigatorKey = navigatorKey;
    requestPermissions();
    getFcmToken();
    _firebaseMessaging.subscribeToTopic('booking_new_movie');
    notificationListeners();
  }

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void requestPermissions() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
  }

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('msgToken', await _firebaseMessaging.getToken());
    print('firebase token => ${await _firebaseMessaging.getToken()}');
    return await _firebaseMessaging.getToken();
  }

  void notificationListeners() {
    _firebaseMessaging.configure(
        onMessage: _onNotificationMessage,
        onResume: _onNotificationResume,
        onLaunch: _onNotificationLaunch);
  }

  Future<dynamic> _onNotificationMessage(Map<dynamic, dynamic> message) async {
    // _notificationSubject.add(message);
    _onMessageStreamController.add(message);

    print(
        "from firebase messages =-=-=> ${message is Map} ${message['data']['body']}");

    print("------- ON MESSAGE ---${message['data']['type']}");
  }

  Future<dynamic> _onNotificationResume(Map<dynamic, dynamic> message) async {
    print(
        "------- ON RESUME ----=[${message['data']['movieId']}]----- $message");

    navigatorKey.currentState.push(PageRouteBuilder(pageBuilder: (_, __, ___) {
      return NotificationsPage();
    }));
  }

  Future<dynamic> _onNotificationLaunch(Map<dynamic, dynamic> message) async {
    print("-ON RESUME =[$message");

    navigatorKey.currentState.push(PageRouteBuilder(pageBuilder: (_, __, ___) {
      return NotificationsPage();
    }));
  }

  void killNotification() {}
}

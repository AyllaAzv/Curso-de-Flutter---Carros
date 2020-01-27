import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging fcm;

void initFcm() {
  if (fcm == null) {
    fcm = FirebaseMessaging();
  }

  fcm.getToken().then((token) {
    print("\n******\nFirebase Token $token\n******\n");
  });

  fcm.subscribeToTopic("all");

  fcm.configure(
    //APP ABERTO
    onMessage: (Map<String, dynamic> message) async {
      print('\n\n\n*** on message $message');
    },
    //APP EM BACKGROUND
    onResume: (Map<String, dynamic> message) async {
      print('\n\n\n*** on resume $message');
    },
    //APP FECHADO
    onLaunch: (Map<String, dynamic> message) async {
      print('\n\n\n*** on launch $message');
    },
  );

  if (Platform.isIOS) {
    fcm.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    fcm.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("iOS Push Settings: [$settings]");
    });
  }
}

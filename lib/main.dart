import 'dart:async';
import 'dart:io';

import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/key_res.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/chat_screen/chat_screen.dart';
import 'package:bubbly/view/email/sign_in_screen.dart';
import 'package:bubbly/view/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'generated/l10n.dart';
import 'firebase_options.dart';
import 'view/email/sign_up_screen.dart';

SessionManager sessionManager = SessionManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
    ignoreSsl: true,
  );
  await sessionManager.initPref();
  AppRes.selectedLanguage = sessionManager.getString(KeyRes.languageCode) ??
      Platform.localeName.split('_')[0];
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  String _locale = AppRes.selectedLanguage;

  void setLocale(String value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return ChangeNotifierProvider<MyLoading>(
      create: (context) => MyLoading(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // locale: Locale(_locale),
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          primaryColorDark: colorPrimaryDark,
          scaffoldBackgroundColor: colorPrimaryDark,
          // accentColor: colorTheme,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          colorScheme: ColorScheme(
            primary: colorPrimary,
            onBackground: colorPrimary,
            error: colorTheme,
            brightness: Brightness.light,
            surface: colorPrimary,
            secondary: colorTheme,
            onSurface: colorPrimary,
            onSecondary: colorPrimaryDark,
            onPrimary: colorPrimary,
            background: Colors.transparent,
            // inverseSurface: Colors.transparent,
            onError: Colors.red,
          ),
          toggleableActiveColor: colorIcon,
          fontFamily: fNSfUiRegular,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
            labelLarge: TextStyle(color: Colors.white),
          ),
        ),
        home: MyBubblyApp(),
      ),
    );
  }
}

class MyBubblyApp extends StatefulWidget {
  @override
  _MyBubblyAppState createState() => _MyBubblyAppState();
}

class _MyBubblyAppState extends State<MyBubblyApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  SessionManager _sessionManager = SessionManager();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    saveTokenUpdate();
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Stack(
        children: [
          Center(
            child: Image(
              width: 225,
              image: AssetImage(icLogoHorizontal),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                byFlutterMaster.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: colorTextLight,
                  fontFamily: fNSfUiLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveTokenUpdate() async {
    await _sessionManager.initPref();
    firebaseMessaging.getToken().then(
        (value) => _sessionManager.saveString(ConstRes.deviceToken, value));
    //
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      // print('Message data: ${message.data}');
      //
      // if (message.notification != null) {
      //   print('Message also contained a notification: ${message.notification}');
      // }
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = new IOSInitializationSettings();
      var initializationSettings = new InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      FlutterLocalNotificationsPlugin().initialize(initializationSettings);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;

      if (notification != null && apple != null && !ChatScreen.isScreen) {
        flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(iOS: IOSNotificationDetails()));
      }

      if (notification != null && android != null && !ChatScreen.isScreen) {
        flutterLocalNotificationsPlugin.show(
            1,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ));
      }
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void getUserData() async {
    await _sessionManager.initPref();
    if (_sessionManager.getUser() != null &&
        _sessionManager.getUser()!.data != null) {
      SessionManager.userId = _sessionManager.getUser()!.data!.userId ??
          _sessionManager.getUser()!.data!.userId;
      SessionManager.accessToken = _sessionManager.getUser()!.data!.token ??
          _sessionManager.getUser()!.data!.token;
    }
    await ApiService().fetchSettingsData();
    Timer(
      Duration(seconds: 2),
      () {
        Provider.of<MyLoading>(context, listen: false)
            .setUser(_sessionManager.getUser());
        ConstRes.isDialog == false
            ? SizedBox()
            : Provider.of<MyLoading>(context, listen: false)
                .setIsHomeDialogOpen(true);
        Provider.of<MyLoading>(context, listen: false).setSelectedItem(0);
        ApiService().getNotificationList("0", "100").then((value) {
          if (value.status == 401 &&
              (value.data == null || value.data!.isEmpty)) {
            ApiService().logoutUser();
          }
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
            (Route<dynamic> route) => false);
      },
    );
  }
}

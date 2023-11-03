import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/uservideo/user_video.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/camera/camera_screen.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/explore/explore_screen.dart';
import 'package:bubbly/view/home/home_screen.dart';
import 'package:bubbly/view/login/dialog_login.dart';
import 'package:bubbly/view/notification/notifiation_screen.dart';
import 'package:bubbly/view/profile/proifle_screen.dart';
import 'package:bubbly/view/video/video_list_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> mListOfWidget = [
    HomeScreen(),
    ExploreScreen(),
    NotificationScreen(),
    ProfileScreen(0,
        SessionManager.userId != null ? SessionManager.userId.toString() : ''),
  ];

  SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    initPref();
    initPlugin();

    FlutterBranchSdk.initSession().listen(
      (data) {
        if (data.containsKey("+clicked_branch_link") &&
            data["+clicked_branch_link"] == true) {
          if (data['post_id'] != null) {
            showDialog(
              context: context,
              builder: (context) => LoaderDialog(),
            );
            ApiService()
                .getPostByPostId(data[ConstRes.postId].toString())
                .then((value) {
              List<Data> list = List<Data>.generate(
                1,
                (index) => Data.fromJson(
                  value.data!.toJson(),
                ),
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoListScreen(
                    list: list,
                    index: 0,
                    type: 6,
                  ),
                ),
              );
            });
          } else if (data[ConstRes.userId] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(2, data[ConstRes.userId])),
            );
          }
        }
      },
      onError: (error) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      bottomNavigationBar: Consumer<MyLoading>(
        builder: (context, value, child) {
          return BottomNavigationBar(
            backgroundColor: colorPrimary,
            selectedItemColor: colorIcon,
            unselectedItemColor: colorTextLight,
            type: BottomNavigationBarType.fixed,
            onTap: (value) async {
              Provider.of<MyLoading>(context, listen: false)
                  .setSelectedItem(value);
              if (value >= 2 && SessionManager.userId == -1) {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return DialogLogin();
                  },
                ).then((value) => Provider.of<MyLoading>(context, listen: false)
                    .setSelectedItem(0));
              } else {
                if (value == 2) {
                  PermissionStatus status = await Permission.camera.request();
                  if (Platform.isAndroid && status.isGranted) {
                    PermissionStatus micro =
                        await Permission.microphone.request();
                    if (micro.isGranted) {
                      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                      AndroidDeviceInfo androidInfo =
                          await deviceInfo.androidInfo;
                      if (androidInfo.version.sdkInt >= 33) {
                        PermissionStatus photo =
                            await Permission.photos.request();
                        PermissionStatus video =
                            await Permission.videos.request();
                        if (photo.isGranted == true &&
                            video.isGranted == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(),
                            ),
                          );
                        }
                      } else {
                        PermissionStatus status =
                            await Permission.storage.request();
                        if (status.isGranted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(),
                            ),
                          );
                        }
                      }
                    }
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(),
                      ),
                    );
                  }
                }
              }
            },
            selectedLabelStyle: TextStyle(
              fontFamily: fNSfUiLight,
              color: colorIcon,
              height: 1.5,
              fontSize: 11,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: fNSfUiLight,
              height: 1.5,
              fontSize: 11,
            ),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: value.getSelectedItem,
            items: [
              BottomNavigationBarItem(
                icon: Image(
                  height: 22,
                  width: 22,
                  image: AssetImage(icHome),
                  color:
                      value.getSelectedItem == 0 ? colorIcon : colorTextLight,
                ),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  height: 22,
                  width: 22,
                  image: AssetImage(icExplore),
                  color:
                      value.getSelectedItem == 1 ? colorIcon : colorTextLight,
                ),
                label: S.of(context).explore,
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorTheme,
                        colorPink,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                label: S.of(context).create,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  height: 22,
                  width: 22,
                  image: AssetImage(icNotification),
                  color:
                      value.getSelectedItem == 3 ? colorIcon : colorTextLight,
                ),
                label: S.of(context).notification,
              ),
              BottomNavigationBarItem(
                icon: Image(
                  height: 22,
                  width: 22,
                  image: AssetImage(icUser),
                  color:
                      value.getSelectedItem == 4 ? colorIcon : colorTextLight,
                ),
                label: S.of(context).profile,
              ),
            ],
          );
        },
      ),
      body: Consumer<MyLoading>(
        builder: (context, value, child) {
          return mListOfWidget[value.getSelectedItem >= 2
              ? value.getSelectedItem - 1
              : value.getSelectedItem];
        },
      ),
    );
  }

  void initPref() async {
    await _sessionManager.initPref();
    if (Platform.isIOS && !_sessionManager.getBool(ConstRes.isAccepted)!) {
      Timer(
        Duration(seconds: 1),
        () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: false,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.964,
                decoration: BoxDecoration(
                  color: colorPrimaryDark,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        color: colorPrimary,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).endUserLicenseAgreement,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: WebView(
                        initialUrl: ConstRes.termOfUse,
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    ),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        _sessionManager.saveBoolean(ConstRes.isAccepted, true);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(S.of(context).accept),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;
    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }
}

import 'dart:ui';

import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/setting/setting.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/home/following_screen.dart';
import 'package:bubbly/view/home/for_u_screen.dart';
import 'package:bubbly/view/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    homeScreenDialog();
    prefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(
        initialPage:
            Provider.of<MyLoading>(context, listen: false).isForYou ? 1 : 0,
        keepPage: true);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: BouncingScrollPhysics(),
            controller: controller,
            children: [
              FollowingScreen(),
              ForYouScreen(),
            ],
            onPageChanged: (value) {
              Provider.of<MyLoading>(context, listen: false)
                  .setIsForYouSelected(value == 1);
            },
          ),
          Consumer<MyLoading>(
            builder: (BuildContext context, myLoading, Widget? child) {
              return Padding(
                padding: EdgeInsets.only(top: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        controller.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInToLinear);
                      },
                      child: Text(
                        following,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: fNSfUiSemiBold,
                          color: !myLoading.isForYou
                              ? Colors.white
                              : Colors.white.withOpacity(0.7),
                          shadows: [
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              color: !myLoading.isForYou
                                  ? Colors.black54
                                  : Colors.transparent,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 25,
                      width: 2,
                      color: colorTheme,
                    ),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInToLinear);
                      },
                      child: Text(
                        forYou,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: fNSfUiSemiBold,
                          color: myLoading.isForYou
                              ? Colors.white
                              : colorTextLight,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              color: myLoading.isForYou
                                  ? Colors.black54
                                  : Colors.transparent,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> homeScreenDialog() async {
    await Future.delayed(Duration.zero);
    Provider.of<MyLoading>(context, listen: false).getIsHomeDialogOpen
        ? showDialog(
            context: context,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Dialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 55),
                    backgroundColor: Colors.transparent,
                    child: AspectRatio(
                      aspectRatio: 1 / 1.2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorPrimaryDark,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              S.of(context).pleaseAccept,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: fNSfUiSemiBold,
                                decoration: TextDecoration.none,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Image(
                              image: AssetImage(icLogo),
                              height: 70,
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                S
                                    .of(context)
                                    .pleaseCheckThesePrivacyPolicyAndTermsOfUseBefore,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: fNSfUiLight,
                                  decoration: TextDecoration.none,
                                  color: colorTextLight,
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WebViewScreen(2),
                                        ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      S.of(context).termsConditions,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: fNSfUiLight,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: 2,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              WebViewScreen(3),
                                        ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      S.of(context).privacyPolicy,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: fNSfUiLight,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                Provider.of<MyLoading>(context, listen: false)
                                    .setIsHomeDialogOpen(false);
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                  color: colorPrimary,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).accept,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: fNSfUiLight,
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            barrierDismissible: true)
        : SizedBox();
  }

  void prefData() async {
    await sessionManager.initPref();
    Setting? setting = sessionManager.getSetting();
    SettingRes.admobBanner = setting?.data?.admobBanner;
    SettingRes.admobInt = setting?.data?.admobInt;
    SettingRes.admobIntIos = setting?.data?.admobIntIos;
    SettingRes.admobBannerIos = setting?.data?.admobBannerIos;
    SettingRes.maxUploadDaily = setting?.data?.maxUploadDaily;
    SettingRes.liveMinViewers = setting?.data?.liveMinViewers;
    SettingRes.liveTimeout = setting?.data?.liveTimeout;
    SettingRes.rewardVideoUpload = setting?.data?.rewardVideoUpload;
    SettingRes.minFansForLive = setting?.data?.minFansForLive;
    SettingRes.minFansVerification = setting?.data?.minFansVerification;
    SettingRes.minRedeemCoins = setting?.data?.minRedeemCoins;
    SettingRes.coinValue = setting?.data?.coinValue;
    SettingRes.currency = setting?.data?.currency;
    SettingRes.agoraAppId = setting?.data?.agoraAppId.toString() ?? '';
    SettingRes.gifts = setting?.data?.gifts;
  }
}

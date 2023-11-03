import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/main.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/key_res.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/dialog/simple_dialog.dart';
import 'package:bubbly/view/languages_screen/languages_screen.dart';
import 'package:bubbly/view/qrcode/my_qr_code_screen.dart';
import 'package:bubbly/view/verification/verification_screen.dart';
import 'package:bubbly/view/wallet/wallet_screen.dart';
import 'package:bubbly/view/webview/webview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55,
              child: Stack(
                children: [
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      S.of(context).settings,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.3,
              color: colorTextLight,
            ),
            CenterArea(
              shareLink: shareLink,
            )
          ],
        ),
      ),
    );
  }

  void shareLink(BuildContext context) async {
    User user = Provider.of<MyLoading>(context, listen: false).getUser!;
    BranchUniversalObject buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        title: user.data!.userName!,
        imageUrl: ConstRes.itemBaseUrl + user.data!.userProfile!,
        contentDescription: '',
        publiclyIndex: true,
        locallyIndex: true,
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata(ConstRes.userId, user.data!.userId));
    BranchLinkProperties lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        tags: ['one', 'two', 'three']);
    lp.addControlParam('url', 'http://www.google.com');
    lp.addControlParam('url2', 'http://flutter.dev');
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      Share.share(
        AppRes.checkOutThisAmazingProfile(response.result),
        subject: '${AppRes.look} ${user.data!.userName}',
      );
    } else {
      print('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }
}

class CenterArea extends StatefulWidget {
  final Function(BuildContext context) shareLink;

  const CenterArea({Key? key, required this.shareLink}) : super(key: key);

  @override
  State<CenterArea> createState() => _CenterAreaState();
}

class _CenterAreaState extends State<CenterArea> {
  SessionManager sessionManager = SessionManager();
  int followers = 0;
  User? user;
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    prefData();
    super.initState();
  }

  void prefData() async {
    await sessionManager.initPref();
    user = sessionManager.getUser();
    followers = sessionManager.getUser()?.data?.followersCount ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 13,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: colorIcon,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        S.of(context).account,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Image.asset(
                                icNotificationBorder,
                                height: 17,
                                color: colorIcon,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                S.of(context).notifyMe,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colorTextLight,
                                ),
                              ),
                              Spacer(),
                              Container(),
                              NotificationSwitch()
                            ],
                          ),
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LanguagesScreen(),
                            ),
                          ),
                          child:
                              ItemSetting(S.of(context).languages, icTranslate),
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () => widget.shareLink(context),
                          child: ItemSetting(
                              S.of(context).shareProfile, icShareBorder),
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyQrScanCodeScreen(),
                            ),
                          ),
                          child: ItemSetting(S.of(context).myQrCode, icQrCode),
                        ),
                        InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WalletScreen(),
                                  ),
                                ),
                            child: ItemSetting(S.of(context).wallet, icWallet)),
                        Visibility(
                          visible:
                              Provider.of<MyLoading>(context, listen: false)
                                      .getUser!
                                      .data!
                                      .isVerify ==
                                  0,
                          child: InkWell(
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                print(SettingRes.minFansVerification);
                                print(followers);
                                if (SettingRes.minFansVerification! >
                                    followers) {
                                  return CommonUI.showToast(
                                      msg:
                                          '${S.of(context).minimumFollower} ${SettingRes.minFansVerification}');
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VerificationScreen(),
                                    ),
                                  );
                                }
                              },
                              child: ItemSetting(
                                  S.of(context).requestVerification,
                                  icVerified)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: colorIcon,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        S.of(context).general,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(1),
                                  ),
                                ),
                            child: ItemSetting(S.of(context).help, icHelp)),
                        InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(2),
                                  ),
                                ),
                            child:
                                ItemSetting(S.of(context).termsOfUse, icTerms)),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewScreen(3),
                            ),
                          ),
                          child: ItemSetting(
                              S.of(context).privacyPolicy, icPrivacy),
                        ),
                        InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleCustomDialog(
                                title: S.of(context).areYouSure,
                                message: S
                                    .of(context)
                                    .allOfYourDataIncludingPostsnLikesFollowsAndEverything,
                                negativeText: S.of(context).cancel,
                                positiveText: S.of(context).confirm,
                                onButtonClick: (clickType) async {
                                  if (clickType == 1) {
                                    if (user?.data?.loginType == KeyRes.email) {
                                      await u.FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: user?.data?.identity ?? '',
                                              password:
                                                  sessionManager.getString(
                                                          KeyRes.password) ??
                                                      '')
                                          .then((value) {
                                        value.user?.delete();
                                      });
                                    }
                                    ApiService().deleteAccount().then(
                                      (value) async {
                                        await db
                                            .collection(
                                                FirebaseConst.userChatList)
                                            .doc(user?.data?.identity)
                                            .collection(FirebaseConst.userList)
                                            .get()
                                            .then((value) {
                                          value.docs.forEach((element) {
                                            db
                                                .collection(
                                                    FirebaseConst.userChatList)
                                                .doc(element.id)
                                                .collection(
                                                    FirebaseConst.userList)
                                                .doc(user?.data?.identity)
                                                .update({
                                              FirebaseConst.isDeleted: true,
                                              FirebaseConst.deletedId:
                                                  '${DateTime.now().millisecondsSinceEpoch}',
                                              FirebaseConst.block: false,
                                              FirebaseConst.blockFromOther:
                                                  false,
                                            });
                                            db
                                                .collection(
                                                    FirebaseConst.userChatList)
                                                .doc(user?.data?.identity)
                                                .collection(
                                                    FirebaseConst.userList)
                                                .doc(element.id)
                                                .update({
                                              FirebaseConst.isDeleted: true,
                                              FirebaseConst.deletedId:
                                                  '${DateTime.now().millisecondsSinceEpoch}',
                                              FirebaseConst.block: false,
                                              FirebaseConst.blockFromOther:
                                                  false,
                                            });
                                          });
                                        });
                                        Navigator.pop(context);
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyBubblyApp()),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                    );
                                  } else {}
                                },
                              ),
                            );
                          },
                          child: ItemSetting(
                              S.of(context).deleteAccount, icRemoveAccount),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleCustomDialog(
                      title: S.of(context).areYouSure,
                      message: S.of(context).doYoReallyNwantToLogOut,
                      negativeText: S.of(context).cancel,
                      positiveText: S.of(context).confirm,
                      onButtonClick: (clickType) async {
                        if (clickType == 1) {
                          if (Provider.of<MyLoading>(context, listen: false)
                                  .getUser!
                                  .data!
                                  .loginType ==
                              "0") {
                            logOutUser(context);
                          } else {
                            GoogleSignIn().signOut().then((value) {
                              logOutUser(context);
                            });
                          }
                        }
                      },
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(colorPrimary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.power_settings_new,
                          color: colorPrimary,
                          size: 15,
                        ),
                        backgroundColor: colorIcon,
                        radius: 10,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        S.of(context).logOut.toUpperCase(),
                        style: TextStyle(
                          color: colorIcon,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logOutUser(BuildContext context) {
    ApiService().logoutUser().then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyBubblyApp()),
            (Route<dynamic> route) => false);
      },
    );
  }
}

class NotificationSwitch extends StatefulWidget {
  @override
  _NotificationSwitchState createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  var currentValue = true;
  SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    initSessionManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (value) {
        currentValue = value;
        ApiService().setNotificationSettings(currentValue
            ? _sessionManager.getString(ConstRes.deviceToken)
            : 'destroy');
        setState(() {});
      },
      value: currentValue,
    );
  }

  void initSessionManager() async {
    await _sessionManager.initPref();
  }
}

class ItemSetting extends StatelessWidget {
  final String image;
  final String text;

  ItemSetting(this.text, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 16,
            color: colorIcon,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: fNSfUiMedium,
              color: colorTextLight,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/modal/live_stream/live_stream.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/common_fun.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/live_stream/screen/audience_screen.dart';
import 'package:bubbly/view/live_stream/screen/broad_cast_screen.dart';
import 'package:bubbly/view/live_stream/widget/live_stream_end_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

class LiveStreamScreenViewModel extends BaseViewModel {
  SessionManager pref = SessionManager();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<LiveStreamUser> liveUsers = [];
  StreamSubscription<QuerySnapshot<LiveStreamUser>>? userStream;
  List<String> joinedUser = [];
  User? registrationUser;
  BannerAd? bannerAd;

  void init() {
    prefData();
    getBannerAd();
  }

  void prefData() async {
    await pref.initPref();
    registrationUser = pref.getUser();
    getLiveStreamUser();
  }

  void goLiveTap(BuildContext context) async {
    showDialog(
      context: context,
      builder: (c) {
        return Center(
          child: CircularProgressIndicator(
            color: colorPink,
          ),
        );
      },
    );
    await ApiService()
        .generateAgoraToken(registrationUser?.data?.identity)
        .then(
      (value) async {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => BroadCastScreen(
                registrationUser: registrationUser,
                agoraToken: value.token,
                channelName: registrationUser?.data?.identity),
          ),
        );
      },
    );
  }

  void getLiveStreamUser() {
    userStream = db
        .collection(FirebaseConst.liveStreamUser)
        .withConverter(
          fromFirestore: LiveStreamUser.fromFireStore,
          toFirestore: (LiveStreamUser value, options) {
            return value.toFireStore();
          },
        )
        .snapshots()
        .listen((event) {
      liveUsers = [];
      for (int i = 0; i < event.docs.length; i++) {
        liveUsers.add(event.docs[i].data());
      }
      notifyListeners();
    });
  }

  void onImageTap(BuildContext context, LiveStreamUser user) async {
    String authString = '${ConstRes.customerId}:${ConstRes.customerSecret}';
    String authToken = base64.encode(authString.codeUnits);
    showDialog(
      context: context,
      builder: (c) {
        return Center(
          child: CircularProgressIndicator(color: colorLightWhite),
        );
      },
    );

    ApiService()
        .agoraListStreamingCheck(user.hostIdentity ?? '', authToken,
            SettingRes.agoraAppId.toString())
        .then((value) {
      log(value.data!.toJson().toString());
      Navigator.pop(context);
      print(value.data?.toJson());
      if (value.data?.channelExist == true ||
          value.data!.broadcasters!.isNotEmpty) {
        joinedUser.add(registrationUser?.data?.identity ?? '');
        db
            .collection(FirebaseConst.liveStreamUser)
            .doc(user.hostIdentity)
            .update({
          FirebaseConst.watchingCount: user.watchingCount! + 1,
          FirebaseConst.joinedUser: FieldValue.arrayUnion(joinedUser),
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AudienceScreen(
                channelName: user.hostIdentity,
                agoraToken: user.agoraToken,
                user: user,
              ),
            ),
          );
        });
      } else {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (c) {
            return LiveStreamEndSheet(
              name: user.fullName ?? '',
              onExitBtn: () async {
                Navigator.pop(context);
                db
                    .collection(FirebaseConst.liveStreamUser)
                    .doc(user.hostIdentity)
                    .delete();
                final batch = db.batch();
                var collection = db
                    .collection(FirebaseConst.liveStreamUser)
                    .doc(user.hostIdentity)
                    .collection(FirebaseConst.comment);
                var snapshots = await collection.get();
                for (var doc in snapshots.docs) {
                  batch.delete(doc.reference);
                }
                await batch.commit();
              },
            );
          },
        );
      }
    });
  }

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    userStream?.cancel();
    super.dispose();
  }
}

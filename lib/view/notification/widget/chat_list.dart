import 'dart:async';

import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/chat/chat.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/chat_screen/chat_screen.dart';
import 'package:bubbly/view/dialog/simple_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  SessionManager sessionManager = SessionManager();
  User? user;
  Stream<QuerySnapshot<Conversation>>? dataStream;

  @override
  void initState() {
    getChatUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Conversation>>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(S.of(context).somethingWentWrong));
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(child: Text(S.of(context).dataNotFound));
        }
        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            Conversation? conversation = snapshot.data?.docs[index].data();
            return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                onUserTap(conversation);
              },
              onLongPress: () {
                onLongPress(conversation);
              },
              child: AspectRatio(
                aspectRatio: 1 / 0.22,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          '${ConstRes.itemBaseUrl}${conversation?.user?.image}',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              icUserPlaceHolder,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${conversation?.user?.userFullName}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Visibility(
                                        visible:
                                            conversation?.user?.isVerified ??
                                                false,
                                        child: Icon(
                                          Icons.verified_sharp,
                                          color: Colors.blueAccent,
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  readTimestamp(conversation?.time ?? 0.0),
                                  style: TextStyle(color: colorTextLight),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    conversation?.lastMsg ?? '',
                                    style: TextStyle(
                                        color: colorTextLight,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Visibility(
                                  visible:
                                      conversation?.user?.isNewMsg ?? false,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: colorIcon,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void onUserTap(Conversation? conversation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(user: conversation),
      ),
    );
  }

  getChatUsers() async {
    await sessionManager.initPref();
    user = sessionManager.getUser();
    dataStream = db
        .collection(FirebaseConst.userChatList)
        .doc(user?.data?.identity)
        .collection(FirebaseConst.userList)
        .where(FirebaseConst.isDeleted, isEqualTo: false)
        .orderBy(FirebaseConst.time, descending: true)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .snapshots();
    if (this.mounted) {
      setState(() {});
    }
  }

  static String readTimestamp(double timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMicrosecondsSinceEpoch(timestamp.toInt() * 1000);
    var time = '';
    if (now.day == date.day) {
      time = DateFormat('hh:mm a', 'en')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.weekday > date.weekday) {
      time = DateFormat('EEEE', 'en')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    if (now.month == date.month) {
      time = DateFormat('dd/MM/yyyy', 'en')
          .format(DateTime.fromMillisecondsSinceEpoch(timestamp.toInt()));
      return time;
    }
    return time;
  }

  @override
  void dispose() {
    dataStream?.listen((event) {}).cancel();
    super.dispose();
  }

  void onLongPress(Conversation? conversation) {
    HapticFeedback.vibrate();
    print(user?.data?.identity);
    print(conversation?.user?.userIdentity);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SimpleCustomDialog(
            title: S.of(context).deleteThisChat,
            message:
                S.of(context).messageWillOnlyBeRemovedFromThisDevicenareYouSure,
            negativeText: S.of(context).cancel,
            positiveText: S.of(context).deleteChat,
            onButtonClick: (clickType) {
              if (clickType == 1) {
                db
                    .collection(FirebaseConst.userChatList)
                    .doc(user?.data?.identity)
                    .collection(FirebaseConst.userList)
                    .doc(conversation?.user?.userIdentity)
                    .update({
                  FirebaseConst.isDeleted: true,
                  FirebaseConst.deletedId:
                      '${DateTime.now().millisecondsSinceEpoch}',
                  FirebaseConst.block: false,
                  FirebaseConst.blockFromOther: false,
                }).then((value) {
                  Navigator.pop(context);
                });
              }
            });
      },
    );
    setState(() {});
  }
}

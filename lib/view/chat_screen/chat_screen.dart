import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/chat/chat.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/chat_screen/widget/add_btn_sheet.dart';
import 'package:bubbly/view/chat_screen/widget/bottom_input_bar.dart';
import 'package:bubbly/view/chat_screen/widget/chat_area.dart';
import 'package:bubbly/view/chat_screen/widget/image_video_msg_screen.dart';
import 'package:bubbly/view/chat_screen/widget/top_bar_area.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final Conversation? user;

  static bool isScreen = false;

  const ChatScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Conversation? conversation;
  User? user;
  User? conversationUserData;
  SessionManager sessionManager = SessionManager();
  var db = FirebaseFirestore.instance;
  late DocumentReference drReceiver;
  late DocumentReference drSender;
  late CollectionReference drChatMessage;
  List<String> notDeletedIdentity = [];
  Map<String, List<ChatMessage>>? grouped;
  ChatUser? receiverUser;
  StreamSubscription<QuerySnapshot<ChatMessage>>? chatStream;
  TextEditingController controller = TextEditingController();
  List<ChatMessage> chatData = [];
  List<String> timeStamp = [];
  bool isLongPress = false;
  bool? isBlockFromOther = false;
  StreamSubscription<DocumentSnapshot<Conversation>>? blockFromOtherStream;
  String deletedId = '';

  @override
  void initState() {
    ChatScreen.isScreen = true;
    conversation = widget.user;
    getProfile();
    prefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarArea(
            user: conversation,
            onBack: () {
              Navigator.pop(context);
            },
            conversation: conversation,
          ),
          ChatArea(
            chatData: grouped,
            onLongPress: onLongPress,
            timeStamp: timeStamp,
          ),
          BottomInputBar(
            msgController: controller,
            onShareBtnTap: () {
              if (isBlockFromOther == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).youAreBlockFromOther)));
              } else {
                onShareBtnTap();
              }
            },
            onAddBtnTap: () {
              if (isBlockFromOther == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).youAreBlockFromOther)));
              } else {
                onAddBtnTap();
              }
            },
            onCameraTap: () {
              if (isBlockFromOther == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.of(context).youAreBlockFromOther)));
              } else {
                onCameraTap(context);
              }
            },
            timeStamp: timeStamp,
            onDeleteBtnClick: onDeleteBtnClick,
            cancelBtnClick: onCancelBtnClick,
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  void onCameraTap(BuildContext context) async {
    File? images;
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (image == null || image.path.isEmpty) return;
    images = File(image.path);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ImageVideoMsgScreen(
          image: images?.path,
          onIVSubmitClick: ({text}) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: colorPink,
                  ),
                );
              },
            );
            ApiService().filePath(filePath: images).then((value) {
              firebaseMsgUpdate(
                  msgType: FirebaseConst.image,
                  image: value.path,
                  video: null,
                  textMessage: text);
            }).then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
        );
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onShareBtnTap() {
    if (controller.text.trim() != '') {
      firebaseMsgUpdate(
              msgType: FirebaseConst.msg, textMessage: controller.text.trim())
          .then((value) {
        controller.clear();
      });
    }
  }

  String dateFormat(DateTime time) {
    String hour = time.hour.toString();
    String minute = time.minute.toString().padLeft(2, '0');
    bool isAm = (time.hour * 60) > 719 ? false : true;
    String timeStr = '$hour:$minute ${isAm ? 'am' : 'pm'}';
    return timeStr;
  }

  void prefData() async {
    await sessionManager.initPref();
    user = sessionManager.getUser();
    initFireStore();
  }

  void getProfile() {
    ApiService().getProfile('${conversation?.user?.userid}').then((value) {
      conversationUserData = value;
      setState(() {});
    });
    ApiService().getProfile(SessionManager.userId.toString()).then((value) {
      user = value;
      setState(() {});
    });
  }

  void initFireStore() {
    drReceiver = db
        .collection(FirebaseConst.userChatList)
        .doc(conversation?.user?.userIdentity)
        .collection(FirebaseConst.userList)
        .doc(user?.data?.identity);

    drSender = db
        .collection(FirebaseConst.userChatList)
        .doc(user?.data?.identity)
        .collection(FirebaseConst.userList)
        .doc(conversation?.user?.userIdentity);

    drSender
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .get()
        .then(
      (value) async {
        if (value.data() != null && value.data()?.conversationId != null) {
          conversation?.setConversationId(value.data()?.conversationId);
        }
        drChatMessage = db
            .collection(FirebaseConst.chat)
            .doc(conversation?.conversationId)
            .collection(FirebaseConst.chat);
        getChat();
      },
    );
  }

  void getChat() async {
    await drReceiver
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .get()
        .then(
      (value) {
        receiverUser = value.data()?.user;
      },
    );

    await drSender
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .get()
        .then((value) {
      deletedId = value.data()?.deletedId.toString() ?? '';
      setState(() {});
    });

    chatStream = drChatMessage
        .where(FirebaseConst.noDeletedId, arrayContains: user?.data?.identity)
        .where(FirebaseConst.time,
            isGreaterThan: deletedId.isEmpty ? 0.0 : double.parse(deletedId))
        .orderBy(FirebaseConst.time, descending: true)
        .withConverter(
          fromFirestore: ChatMessage.fromFireStore,
          toFirestore: (ChatMessage value, options) {
            return value.toFireStore();
          },
        )
        .snapshots()
        .listen(
      (element) async {
        chatData = [];
        for (int i = 0; i < element.docs.length; i++) {
          chatData.add(element.docs[i].data());
        }
        grouped = groupBy<ChatMessage, String>(
          chatData,
          (message) {
            final now = DateTime.now();
            DateTime time =
                DateTime.fromMillisecondsSinceEpoch(message.time!.toInt());
            if (DateFormat("dd MMM yyyy", 'en').format(DateTime.now()) ==
                DateFormat("dd MMM yyyy", 'en').format(time)) {
              return 'Today';
            }
            if (DateFormat("dd MMM yyyy", 'en')
                    .format(DateTime(now.year, now.month, now.day - 1)) ==
                DateFormat("dd MMM yyyy", 'en').format(time)) {
              return 'Yesterday';
            } else {
              return DateFormat("dd MMM yyyy", 'en').format(time);
            }
          },
        );
        setState(() {});
      },
    );
  }

  Future<void> firebaseMsgUpdate(
      {required String msgType,
      String? textMessage,
      String? image,
      String? video}) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    notDeletedIdentity = [];
    notDeletedIdentity.addAll(
      ['${user?.data?.identity}', '${conversation?.user?.userIdentity}'],
    );

    drChatMessage
        .doc(
          time.toString(),
        )
        .set(
          ChatMessage(
            notDeletedIdentities: notDeletedIdentity,
            senderUser: ChatUser(
              username: user?.data?.userName,
              userFullName: user?.data?.fullName,
              date: time.toDouble(),
              isNewMsg: true,
              userid: user?.data?.userId,
              userIdentity: user?.data?.identity,
              image: user?.data?.userProfile,
              isVerified: user?.data?.isVerify == 1 ? true : false,
            ),
            msgType: msgType,
            msg: textMessage,
            image: image,
            video: video,
            id: conversation?.user?.userid?.toString(),
            time: time.toDouble(),
          ).toJson(),
        );

    if (chatData.isEmpty && deletedId.isEmpty) {
      Map con = conversation?.toJson() ?? {};
      con[FirebaseConst.lastMsg] = msgType == FirebaseConst.image
          ? '🖼️ ${FirebaseConst.image}'
          : msgType == FirebaseConst.video
              ? '🎥 ${FirebaseConst.video}'
              : textMessage;
      drSender.set(con);
      drReceiver.set(
        Conversation(
          block: false,
          blockFromOther: false,
          conversationId: conversation?.conversationId,
          deletedId: '',
          isDeleted: false,
          isMute: false,
          lastMsg: msgType == FirebaseConst.image
              ? '🖼️ ${FirebaseConst.image}'
              : msgType == FirebaseConst.video
                  ? '🎥 ${FirebaseConst.video}'
                  : textMessage,
          newMsg: textMessage,
          time: time.toDouble(),
          user: ChatUser(
            username: user?.data?.userName,
            userIdentity: user?.data?.identity,
            userid: user?.data?.userId,
            userFullName: user?.data?.fullName ?? '',
            isNewMsg: false,
            image: user?.data?.userProfile,
            date: time.toDouble(),
            isVerified: user?.data?.isVerify == 1 ? true : false,
          ),
        ).toJson(),
      );
    } else {
      receiverUser?.isNewMsg = true;
      drReceiver.update(
        {
          FirebaseConst.isDeleted: false,
          FirebaseConst.time: time.toDouble(),
          FirebaseConst.lastMsg: msgType == FirebaseConst.image
              ? AppRes.imageMessage
              : msgType == FirebaseConst.video
                  ? AppRes.videoMessage
                  : textMessage,
          FirebaseConst.user: receiverUser?.toJson(),
        },
      );
      // sender update
      drSender.update(
        {
          FirebaseConst.isDeleted: false,
          FirebaseConst.time: time.toDouble(),
          FirebaseConst.lastMsg: msgType == FirebaseConst.image
              ? AppRes.imageMessage
              : msgType == FirebaseConst.video
                  ? AppRes.videoMessage
                  : textMessage
        },
      );
    }

    ApiService().pushNotification(
        authorization: ConstRes.auth,
        title: user?.data?.fullName ?? 'Shortzz',
        body: msgType == FirebaseConst.image
            ? AppRes.imageMessage
            : msgType == FirebaseConst.video
                ? AppRes.videoMessage
                : (textMessage ?? ''),
        token: '${conversationUserData?.data?.deviceToken}');
  }

  void onAddBtnTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AddBtnSheet(
          fireBaseMsg: ({imagePath, msg, msgType, videoPath}) {
            firebaseMsgUpdate(
                msgType: msgType ?? '',
                image: imagePath,
                video: msgType == FirebaseConst.video ? videoPath : null,
                textMessage: msg);
          },
        );
      },
    );
  }

  void onCancelBtnClick() {
    timeStamp = [];
    setState(() {});
  }

  void onDeleteBtnClick() {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 70),
            child: AspectRatio(
              aspectRatio: 0.6 / 0.4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorPrimaryDark,
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      S.of(context).deleteMessage,
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        S.of(context).areYouSureYouWantToDeleteThisMessage,
                        style: TextStyle(color: colorTextLight),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fNSfUiLight,
                                    decoration: TextDecoration.none,
                                    color: colorTextLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                Navigator.pop(context);
                                onDeleteYesBtnClick();
                              },
                              child: Center(
                                child: Text(
                                  S.of(context).delete,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: fNSfUiLight,
                                    decoration: TextDecoration.none,
                                    color: colorIcon,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onDeleteYesBtnClick() {
    for (int i = 0; i < timeStamp.length; i++) {
      drChatMessage.doc(timeStamp[i]).update(
        {
          FirebaseConst.noDeletedId: FieldValue.arrayRemove(
            ['${user?.data?.identity}'],
          )
        },
      );
      chatData.removeWhere(
        (element) => element.time.toString() == timeStamp[i],
      );
    }
    timeStamp = [];
    setState(() {});
  }

  void onLongPress(ChatMessage? data) {
    if (!timeStamp.contains('${data?.time?.round()}')) {
      timeStamp.add('${data?.time?.round()}');
    } else {
      timeStamp.remove('${data?.time?.round()}');
    }
    print(timeStamp);
    isLongPress = true;
    setState(() {});
  }

  @override
  void dispose() {
    drSender
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Conversation.fromJson(snapshot.data()!),
          toFirestore: (Conversation value, options) {
            return value.toJson();
          },
        )
        .get()
        .then(
      (value) {
        var senderUser = value.data()?.user;
        senderUser?.isNewMsg = false;
        drSender.update(
          {
            FirebaseConst.user: senderUser?.toJson(),
          },
        );
      },
    );
    chatStream?.cancel();
    blockFromOtherStream?.cancel();
    ChatScreen.isScreen = false;
    super.dispose();
  }
}

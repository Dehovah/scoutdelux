import 'dart:io';

import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/webview/webview_screen.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadScreen extends StatefulWidget {
  final String? postVideo;
  final String? thumbNail;
  final String? sound;
  final String? soundId;

  UploadScreen({this.postVideo, this.thumbNail, this.sound, this.soundId});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  ValueNotifier<int> textSize = ValueNotifier<int>(0);
  String postDes = '';
  String currentHashTag = '';
  List<String> hashTags = [];
  SessionManager _sessionManager = SessionManager();

  @override
  void initState() {
    initSessionManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      decoration: BoxDecoration(
        color: colorPrimaryDark,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).uploadVideo,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Image(
                  height: 160,
                  width: 110,
                  fit: BoxFit.cover,
                  image: FileImage(File(widget.thumbNail!)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).describe,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      height: 130,
                      child: DetectableTextField(
                        decoratedStyle: TextStyle(
                          fontFamily: fNSfUiBold,
                          letterSpacing: 0.6,
                          fontSize: 13,
                        ),
                        basicStyle: TextStyle(
                          fontFamily: fNSfUiRegular,
                          letterSpacing: 0.6,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(175),
                        ],
                        enableSuggestions: false,
                        maxLines: 8,
                        onChanged: (value) {
                          textSize.value = value.length;
                          postDes = value;
                        },
                        onDetectionTyped: (text) {
                          currentHashTag = text.split("#")[1];
                        },
                        onDetectionFinished: () {
                          if (currentHashTag.isNotEmpty) {
                            hashTags.add(currentHashTag);
                            currentHashTag = '';
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.of(context).awesomeCaption,
                          hintStyle: TextStyle(
                            color: colorTextLight,
                          ),
                        ),
                        detectionRegExp: detectionRegExp(hashtag: true)!,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: EdgeInsets.only(right: 15),
              child: ValueListenableBuilder(
                valueListenable: textSize,
                builder: (context, dynamic value, child) => Text(
                  '$value/${AppRes.textTotalCount}',
                  style: TextStyle(
                    color: colorTextLight,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                if (currentHashTag.isNotEmpty) {
                  hashTags.add(currentHashTag);
                  currentHashTag = '';
                }
                showDialog(
                  context: context,
                  builder: (context) => LoaderDialog(),
                );
                if (widget.soundId != null) {
                  ApiService()
                      .addPost(
                    postVideo: File(widget.postVideo ?? ''),
                    thumbnail: File(widget.thumbNail ?? ''),
                    duration: '1',
                    isOrignalSound: '0',
                    postDescription: postDes,
                    postHashTag: hashTags.join(","),
                    soundId: widget.soundId,
                  )
                      .then(
                    (value) {
                      if (value.status == 200) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        CommonUI.showToast(
                            msg: S.of(context).postUploadSuccessfully);
                      } else if (value.status == 401) {
                        CommonUI.showToast(msg: "${value.message}");
                        Navigator.pop(context);
                      }
                    },
                  );
                } else {
                  ApiService()
                      .addPost(
                    postVideo: File(widget.postVideo!),
                    thumbnail: File(widget.thumbNail!),
                    postSound: File(widget.sound!),
                    duration: '1',
                    isOrignalSound: widget.soundId != null ? '0' : '1',
                    postDescription: postDes,
                    postHashTag: hashTags.join(","),
                    singer: _sessionManager.getUser()?.data?.fullName,
                    soundImage: File(widget.thumbNail!),
                    soundTitle: 'Original Sound',
                    soundId: widget.soundId,
                  )
                      .then(
                    (value) {
                      if (value.status == 200) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        CommonUI.showToast(
                            msg: S.of(context).postUploadSuccessfully);
                      } else if (value.status == 401) {
                        CommonUI.showToast(msg: "${value.message}");
                      }
                    },
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorTheme,
                      colorPink,
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                width: 150,
                height: 40,
                child: Center(
                  child: Text(
                    S.of(context).publish.toUpperCase(),
                    style: TextStyle(
                      fontFamily: fNSfUiBold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            AppRes.privacyPolicy,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: fNSfUiLight,
              color: colorTextLight,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewScreen(3),
              ),
            ),
            child: Text(
              S.of(context).policyCenter,
              style: TextStyle(
                color: colorTheme,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void initSessionManager() async {
    await _sessionManager.initPref();
  }
}

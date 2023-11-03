import 'dart:async';

import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/comment/comment.dart';
import 'package:bubbly/modal/uservideo/user_video.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/utils/my_loading/costumview/data_not_found.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/comment/item_comment.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/login/dialog_login.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final Data? videoData;
  final Function onComment;

  CommentScreen(this.videoData, this.onComment);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final ScrollController _scrollController = ScrollController();
  final StreamController _streamController =
      StreamController<List<CommentData>?>();

  List<CommentData> commentList = [];

  int start = 0;

  bool isLoading = true;
  final TextEditingController _editingController = TextEditingController();
  String commentText = '';

  @override
  void initState() {
    _scrollController.addListener(
      () {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (!isLoading) {
            callApiForComments();
          }
        }
      },
    );
    callApiForComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
        color: colorPrimaryDark,
      ),
      constraints: BoxConstraints(
        maxHeight: 450,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              color: colorPrimary,
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    '${widget.videoData!.postCommentsCount} ${S.of(context).comments}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                List<CommentData>? userVideo = [];
                if (snapshot.data != null) {
                  userVideo = (snapshot.data as List<CommentData>?)!;
                  commentList.addAll(userVideo);
                  _streamController.add(null);
                }
                return commentList.isEmpty
                    ? DataNotFound()
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 25),
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: commentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemComment(commentList[index], () {
                            ApiService()
                                .deleteComment(
                              commentList[index].commentsId.toString(),
                            )
                                .then((value) {
                              commentList.remove(commentList[index]);
                              widget.videoData!.setPostCommentCount(false);
                              widget.onComment.call();
                              setState(() {});
                            });
                          });
                        },
                      );
              },
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: colorPrimary,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      commentText = value;
                    },
                    controller: _editingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).leaveYourComment,
                      hintStyle: TextStyle(
                        color: colorTextLight,
                        fontFamily: fNSfUiRegular,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fNSfUiMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 8,
                  ),
                  child: ClipOval(
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        if (commentText.isEmpty) {
                          CommonUI.showToast(
                              msg: S.of(context).enterCommentFirst);
                        } else {
                          if (SessionManager.userId == -1) {
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
                            );
                            return;
                          }
                          showDialog(
                            context: context,
                            builder: (context) => LoaderDialog(),
                          );
                          ApiService()
                              .addComment(
                            commentText,
                            widget.videoData!.postId.toString(),
                          )
                              .then(
                            (value) {
                              commentList = [];
                              start = 0;
                              Navigator.pop(context);
                              _editingController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                              widget.videoData!.setPostCommentCount(true);
                              widget.onComment();
                              callApiForComments();
                            },
                          );
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colorTheme,
                              colorPink,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void callApiForComments() {
    isLoading = true;
    ApiService()
        .getCommentByPostId(start.toString(), ConstRes.count.toString(),
            widget.videoData!.postId.toString())
        .then((value) {
      start += ConstRes.count;
      isLoading = false;
      _streamController.add(value.data);
    });
  }
}

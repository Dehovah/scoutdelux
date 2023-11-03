import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/uservideo/user_video.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/login/dialog_login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'item_video.dart';

class VideoListScreen extends StatefulWidget {
  final List<Data?>? list;
  final int index;
  final int? type;
  final String? userId;
  final String? soundId;
  final String? hashTag;
  final String? keyWord;

  VideoListScreen({
    required this.list,
    required this.index,
    required this.type,
    this.userId,
    this.soundId,
    this.hashTag,
    this.keyWord,
  });

  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late List<ItemVideo> mList;
  PageController? _pageController;
  String comment = '';
  var start = 0;
  var position = 0;

  var _editingController = TextEditingController();

  @override
  void initState() {
    print(widget.list!.length);
    mList = List.generate(
        widget.list!.length, (index) => ItemVideo(widget.list![index]));
    _pageController = PageController(initialPage: widget.index);
    start = widget.list!.length;
    position = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  pageSnapping: true,
                  onPageChanged: (value) {
                    print(value);
                    if (value == mList.length - 1) {
                      callApiForYou();
                    }
                  },
                  scrollDirection: Axis.vertical,
                  children: mList,
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _editingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.of(context).leaveYourComment,
                          hintStyle: TextStyle(
                            color: colorTextLight,
                            fontFamily: fNSfUiRegular,
                          ),
                        ),
                        onChanged: (value) {
                          comment = value;
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fNSfUiMedium,
                        ),
                      ),
                    ),
                    ClipOval(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (comment.isEmpty) {
                            CommonUI.showToast(
                                msg: S.of(context).enterCommentFirst,
                                toastGravity: ToastGravity.CENTER);
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
                              comment,
                              mList[position].videoData!.postId.toString(),
                            )
                                .then(
                              (value) {
                                Navigator.pop(context);
                                _editingController.clear();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                mList[position]
                                    .videoData!
                                    .setPostCommentCount(true);
                                mList[position].getState().refresh();
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 35,
                          width: 35,
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
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              Navigator.pop(context);
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callApiForYou() {
    ApiService()
        .getPostsByType(
      pageDataType: widget.type,
      userId: widget.userId,
      soundId: widget.soundId,
      hashTag: widget.hashTag,
      keyWord: widget.keyWord,
      start: start.toString(),
      limit: ConstRes.count.toString(),
    )
        .then(
      (value) {
        if (value.data != null && value.data!.isNotEmpty) {
          if (mList.isEmpty) {
            mList = List<Widget>.generate(
              value.data!.length,
              (index) {
                return ItemVideo(value.data![index]);
              },
            ) as List<ItemVideo>;
            setState(() {});
          } else {
            for (Data data in value.data!) {
              mList.add(ItemVideo(data));
            }
          }
          start += ConstRes.count;
          print(mList.length);
        }
      },
    );
  }
}

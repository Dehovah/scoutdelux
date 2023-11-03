import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/view/chat_screen/widget/bottom_delete_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomInputBar extends StatelessWidget {
  final TextEditingController msgController;
  final VoidCallback onShareBtnTap;
  final VoidCallback onAddBtnTap;
  final VoidCallback onCameraTap;
  final List<String> timeStamp;
  final VoidCallback onDeleteBtnClick;
  final VoidCallback cancelBtnClick;

  const BottomInputBar(
      {Key? key,
      required this.msgController,
      required this.onShareBtnTap,
      required this.onAddBtnTap,
      required this.onCameraTap,
      required this.timeStamp,
      required this.onDeleteBtnClick,
      required this.cancelBtnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return timeStamp.isNotEmpty
        ? AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0.0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                  child: child);
            },
            child: BottomDeleteBar(
              timeStamp: timeStamp,
              deleteBtnClick: onDeleteBtnClick,
              cancelBtnClick: cancelBtnClick,
            ))
        : AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(0, 0.0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn,
                    ),
                  ),
                  child: child);
            },
            child: Provider.of<MyLoading>(context, listen: true)
                    .getIsUserBlockOrNot
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 38, vertical: 8),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 9),
                    child: Text(
                      S.of(context).youBlockThisUser,
                      style: TextStyle(color: colorTextLight, fontSize: 12),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: width,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black87,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width - 135,
                                child: TextField(
                                  controller: msgController,
                                  textInputAction: TextInputAction.newline,
                                  minLines: 1,
                                  maxLines: 5,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.only(left: 15, bottom: 3),
                                    border: InputBorder.none,
                                    hintText: S.of(context).typeSomething,
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: colorTextLight,
                                        fontFamily: fNSfUiRegular),
                                  ),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fNSfUiRegular),
                                  cursorColor: colorTextLight,
                                  cursorHeight: 17,
                                  cursorRadius: Radius.circular(5),
                                ),
                              ),
                              InkWell(
                                onTap: onShareBtnTap,
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  alignment: const AlignmentDirectional(0.2, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        colorPink,
                                        colorIcon,
                                      ],
                                    ),
                                  ),
                                  child: Image.asset(backArrow,
                                      height: 16.5, width: 16.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8.5),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: onAddBtnTap,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Image.asset(addIcon, height: 24, width: 24),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: onCameraTap,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Image.asset(cameraIcon, height: 24, width: 24),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
          );
  }
}

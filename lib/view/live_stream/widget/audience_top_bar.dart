import 'package:bubbly/modal/live_stream/live_stream.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/view/live_stream/model/broad_cast_screen_view_model.dart';
import 'package:bubbly/view/live_stream/widget/blur_tab.dart';
import 'package:bubbly/view/report/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AudienceTopBar extends StatelessWidget {
  final BroadCastScreenViewModel model;
  final LiveStreamUser user;

  const AudienceTopBar({Key? key, required this.model, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BlurTab(
            height: 65,
            radius: 15,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      model.onUserTap(context);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      child: ClipOval(
                        child: user.userImage == null || user.userImage!.isEmpty
                            ? Image.asset(
                                icUserPlaceHolder,
                                fit: BoxFit.cover,
                                color: Colors.grey,
                              )
                            : Image.network(
                                "${ConstRes.itemBaseUrl}${user.userImage}",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        model.onUserTap(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                user.fullName ?? '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fNSfUiMedium),
                              ),
                              Visibility(
                                visible: user.isVerified ?? false,
                                child: Image.asset(
                                  icVerify,
                                  height: 15,
                                  width: 15,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${user.followers ?? 0} followers",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontFamily: fNSfUiMedium),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ReportScreen(2, "${user.userId}"),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                    child: Image.asset(
                      icMenu,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BlurTab(
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  icLogo,
                  height: 20,
                ),
                Text(
                  ' LIVE',
                  style: TextStyle(
                      fontFamily: fNSfUiSemiBold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                Spacer(),
                Text(
                  "${NumberFormat.compact(locale: 'en').format(double.parse('${model.liveStreamUser?.watchingCount ?? '0'}'))} Viewers",
                  style: TextStyle(
                      fontFamily: fNSfUiRegular,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    model.audienceExit(context);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        exit,
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Exit",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: fNSfUiMedium),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

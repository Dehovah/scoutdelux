import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/view/live_stream/model/broad_cast_screen_view_model.dart';
import 'package:bubbly/view/live_stream/widget/blur_tab.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BroadCastTopBarArea extends StatelessWidget {
  final BroadCastScreenViewModel model;

  const BroadCastTopBarArea({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlurTab(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                icLogo,
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'Live',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: fNSfUiSemiBold,
                    fontSize: 17),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                "${NumberFormat.compact(locale: 'en').format(double.parse('${model.liveStreamUser?.watchingCount ?? '0'}'))} Viewers",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: fNSfUiMedium,
                    fontSize: 15),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  model.onEndButtonClick(context);
                },
                child: Container(
                  width: 110,
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: Text(
                    'END',
                    style: TextStyle(
                        color: Colors.white, fontFamily: fNSfUiSemiBold),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        BlurTab(
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                icLogo,
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                  "${NumberFormat.compact(locale: 'en').format(double.parse('${model.liveStreamUser?.collectedDiamond ?? '0'}'))} Collected"),
              Spacer(),
              InkWell(
                onTap: model.flipCamera,
                child: Container(
                  padding: EdgeInsets.all(11),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [colorTheme, colorPink]),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(flipCamera, color: Colors.white),
                ),
              ),
              InkWell(
                onTap: model.onMuteUnMute,
                child: Container(
                  padding: EdgeInsets.all(11),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [colorTheme, colorPink]),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    !model.isMic ? biMicFill : biMicMute,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

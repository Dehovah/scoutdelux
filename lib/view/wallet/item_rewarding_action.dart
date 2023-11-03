import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';

class ItemRewardingAction extends StatelessWidget {
  const ItemRewardingAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorTheme,
            radius: 18,
            child: Text(
              '${SettingRes.rewardVideoUpload}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
                fontFamily: fNSfUiSemiBold,
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              S.of(context).wheneverYouUploadVideo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

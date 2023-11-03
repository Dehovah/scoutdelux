import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/common_fun.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/view/notification/widget/chat_list.dart';
import 'package:bubbly/view/notification/widget/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  PageController controller = PageController();

  @override
  void initState() {
    controller = PageController(
        initialPage: Provider.of<MyLoading>(context, listen: false)
            .getNotificationPageIndex,
        keepPage: true);
    getBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Consumer<MyLoading>(
              builder: (context, value, child) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<MyLoading>(context, listen: false)
                            .setNotificationPageIndex(0);
                        controller.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15, top: 20, bottom: 15),
                        child: Text(
                          S.of(context).notifications,
                          style: TextStyle(
                            color: value.getNotificationPageIndex == 0
                                ? Colors.white
                                : colorTextLight,
                            fontFamily: fNSfUiBold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 18,
                      width: 2,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<MyLoading>(context, listen: false)
                            .setNotificationPageIndex(1);
                        controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          S.of(context).chats,
                          style: TextStyle(
                            color: value.getNotificationPageIndex == 1
                                ? Colors.white
                                : colorTextLight,
                            fontFamily: fNSfUiBold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  Provider.of<MyLoading>(context, listen: false)
                      .setNotificationPageIndex(value);
                },
                children: [NotificationList(), ChatList()],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (bannerAd != null)
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: bannerAd!),
                width: bannerAd?.size.width.toDouble(),
                height: bannerAd?.size.height.toDouble(),
              ),
          ],
        ),
      ),
    );
  }

  BannerAd? bannerAd;

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      setState(() {});
    });
  }
}

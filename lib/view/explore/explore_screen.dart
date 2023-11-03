import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/explore/explore_hash_tag.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/common_fun.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/costumview/data_not_found.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/explore/item_explore.dart';
import 'package:bubbly/view/live_stream/screen/live_stream_screen.dart';
import 'package:bubbly/view/login/dialog_login.dart';
import 'package:bubbly/view/qrcode/scan_qr_code_screen.dart';
import 'package:bubbly/view/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int start = 0;

  ScrollController _scrollController = ScrollController();

  List<ExploreData> exploreList = [];
  BannerAd? bannerAd;
  bool isLoading = true;
  bool isHaseMore = true;
  bool isFirstTime = true;

  @override
  void initState() {
    getBannerAd();
    callApiExploreHashTag();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (!isLoading) {
          callApiExploreHashTag();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 45,
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).search,
                            style: TextStyle(
                              color: colorTextLight,
                              fontSize: 15,
                            ),
                          ),
                          Image(
                            height: 20,
                            image: AssetImage(icSearch),
                            color: colorTextLight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
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
                      ).then(
                        (value) =>
                            Provider.of<MyLoading>(context, listen: false)
                                .setSelectedItem(1),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveStreamScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            colorPink,
                            colorTheme,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Image.asset(
                          liveRound,
                          height: 20,
                          width: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).lives.toUpperCase(),
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontFamily: fNSfUiSemiBold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanQrCodeScreen(),
                    ),
                  ),
                  child: Image(
                    height: 20,
                    image: AssetImage(icQrCode),
                    color: colorTextLight,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isFirstTime == true
                  ? Center(
                      child: CircularProgressIndicator(color: colorLightWhite),
                    )
                  : exploreList.isEmpty
                      ? DataNotFound()
                      : ListView(
                          padding: EdgeInsets.only(top: 15),
                          shrinkWrap: true,
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(
                            exploreList.length,
                            (index) => ItemExplore(
                              exploreList[index],
                            ),
                          ),
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

  void getBannerAd() {
    CommonFun.bannerAd((ad) {
      bannerAd = ad as BannerAd;
      setState(() {});
    });
  }

  void callApiExploreHashTag() {
    if (!isHaseMore) {
      return;
    }
    isLoading = true;
    ApiService()
        .getExploreHashTag(
            exploreList.length.toString(), ConstRes.count.toString())
        .then((value) {
      if (isFirstTime) {
        isFirstTime = false;
      }
      if ((value.data?.length ?? 0) < ConstRes.count) {
        isHaseMore = false;
      }
      exploreList.addAll(value.data ?? []);
      isLoading = false;
      setState(() {});
    });
  }
}

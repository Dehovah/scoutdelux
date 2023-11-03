import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/wallet/my_wallet.dart';
import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/common_fun.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/extention_custom.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/webview/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class RedeemScreen extends StatefulWidget {
  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  MyWalletData? _myWalletData;
  String noOfRedeemCoin = '';
  String selectMethod = 'Paypal';
  String account = '';
  InterstitialAd? interstitialAd;

  void _ads() {
    CommonFun.interstitialAd((ad) {
      interstitialAd = ad;
    });
  }

  @override
  void initState() {
    // getCoinRate();
    getMyWalletData();
    _ads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              child: Stack(
                children: [
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).redeemShortzz,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: fNSfUiMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.3,
              color: colorTextLight,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Column(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorPrimaryDark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorPink,
                                      blurRadius: 40,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    NumberFormat.compact(
                                      locale: 'en',
                                    ).format(_myWalletData?.myWallet ?? 0),
                                    style: TextStyle(
                                      fontFamily: fNSfUiBold,
                                      fontSize: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  gradient: LinearGradient(
                                    colors: [
                                      colorTheme,
                                      colorPink,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${AppRes.appName} ${S.of(context).youHave}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: fNSfUiSemiBold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        width: 160,
                        height: 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppRes.redeemTitle(
                            (SettingRes.coinValue ?? 0.0).removeTrailingZeros),
                        style: TextStyle(
                          color: colorTextLight,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          S.of(context).selectMethod,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorPrimary,
                        ),
                        child: SelectMethodDropdown((value) {
                          selectMethod = value;
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          S.of(context).account,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: colorPrimary,
                        ),
                        child: TextField(
                          onChanged: (value) => account = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).mailMobile,
                            hintStyle: TextStyle(
                              color: colorTextLight,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (selectMethod.isEmpty) {
                            CommonUI.showToast(
                                msg: S.of(context).pleaseSelectPaymentMethod);
                          } else if (account.isEmpty) {
                            CommonUI.showToast(
                                msg: S.of(context).pleaseEnterAccount);
                          } else {
                            double amount = ((_myWalletData?.myWallet ?? 0) *
                                    (SettingRes.coinValue!)) /
                                1000;
                            showDialog(
                              context: context,
                              builder: (context) => LoaderDialog(),
                            );
                            ApiService()
                                .redeemRequest(amount.toString(), selectMethod,
                                    account, noOfRedeemCoin)
                                .then((value) {
                              if (value.status == 200) {
                                if (interstitialAd != null) {
                                  interstitialAd?.show().then((value) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              }
                            });
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gradient: LinearGradient(
                              colors: [
                                colorTheme,
                                colorPink,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).redeem.toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: fNSfUiSemiBold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        S
                            .of(context)
                            .redeemRequestsAreProcessedWithIn10DaysnandBePrepared,
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getMyWalletData() {
    ApiService().getMyWalletCoin().then((value) {
      _myWalletData = value.data;
      setState(() {});
    });
  }
}

class SelectMethodDropdown extends StatefulWidget {
  final Function function;

  const SelectMethodDropdown(this.function);

  @override
  _SelectMethodDropdownState createState() => _SelectMethodDropdownState();
}

class _SelectMethodDropdownState extends State<SelectMethodDropdown> {
  String? currentValue = 'Paypal';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
      underline: Container(),
      isExpanded: true,
      elevation: 16,
      style: TextStyle(color: colorTextLight),
      dropdownColor: colorPrimary,
      onChanged: (String? newValue) {
        currentValue = newValue;
        widget.function(currentValue);
        setState(() {});
      },
      items: paymentMethods.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

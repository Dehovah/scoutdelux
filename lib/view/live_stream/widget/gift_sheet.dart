import 'package:bubbly/modal/setting/setting.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GiftSheet extends StatelessWidget {
  final Function(BuildContext context) onAddShortzzTap;
  final User? user;
  final Function(Gifts? gifts) onGiftSend;

  const GiftSheet(
      {Key? key,
      required this.onAddShortzzTap,
      this.user,
      required this.onGiftSend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colorPrimaryDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                      colors: [
                        colorPink,
                        colorTheme,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        icLogo,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${user?.data?.myWallet}',
                        style: TextStyle(fontFamily: fNSfUiLight, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => onAddShortzzTap(context),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft,
                        colors: [
                          colorPink,
                          colorTheme,
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add shortzz',
                      style: TextStyle(fontFamily: fNSfUiLight, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: SettingRes.gifts?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1 / 1.25,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  Gifts? gift = SettingRes.gifts?[index];
                  return InkWell(
                    onTap: () {
                      if (gift!.coinPrice! < user!.data!.myWallet!) {
                        onGiftSend(gift);
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Insufficient Shortzz..! Please purchase shortzz'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      foregroundDecoration: BoxDecoration(
                          color: (gift?.coinPrice ?? 0) >
                                  (user?.data?.myWallet ?? 0)
                              ? colorPrimary.withOpacity(0.7)
                              : Colors.transparent),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              '${ConstRes.itemBaseUrl}${gift?.image}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                icLogo,
                                width: 20,
                                height: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  NumberFormat.compactCurrency(
                                          decimalDigits: 0,
                                          locale: 'en_US',
                                          name: '')
                                      .format(gift?.coinPrice)
                                      .toString(),
                                  style: TextStyle(fontFamily: fNSfUiLight),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

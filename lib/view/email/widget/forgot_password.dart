import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onResetBtnClick;
  final TextEditingController resetPassController;
  final FocusNode resetFocusNode;

  const ForgotPassword(
      {Key? key,
      required this.onResetBtnClick,
      required this.resetPassController,
      required this.resetFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: colorPrimaryDark,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: AspectRatio(
              aspectRatio: 1 / 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, top: 15, left: 15, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            S.of(context).forgotPassword,
                            style: TextStyle(
                                color: colorTextLight,
                                fontSize: 18,
                                fontFamily: fNSfUiMedium),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close_rounded,
                            color: colorTextLight,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      S
                          .of(context)
                          .enterYourMailOnWhichYouHaveCreatedNanAccount,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      S.of(context).email,
                      style: TextStyle(
                          color: Colors.white, fontFamily: fNSfUiSemiBold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      controller: resetPassController,
                      focusNode: resetFocusNode,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      ),
                      cursorColor: colorTextLight,
                      cursorHeight: 15,
                      style: TextStyle(color: colorTextLight),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: InkWell(
                      onTap: onResetBtnClick,
                      child: Material(
                        elevation: 3,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            S.of(context).reset,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

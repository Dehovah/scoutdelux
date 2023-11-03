import 'dart:collection';
import 'dart:io';

import 'package:bubbly/api/api_service.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/app_res.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/key_res.dart';
import 'package:bubbly/utils/my_loading/costumview/common_ui.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/email/widget/login_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  FocusNode referralFocusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;
  final SessionManager sessionManager = SessionManager();

  String fullNameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';

  @override
  void initState() {
    initSessionManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Image(
                          image: AssetImage(icLogo),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          '${S.of(context).signUpFor} ${AppRes.appName}',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: fNSfUiSemiBold,
                              color: colorTextLight),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _title(title: S.of(context).enterYourName),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextFiled(
                          focusNode: nameFocusNode,
                          controller: nameController,
                          obscureText: false),
                      const SizedBox(
                        height: 20,
                      ),
                      _title(title: S.of(context).enterYourMail),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextFiled(
                          focusNode: emailFocusNode,
                          controller: emailController,
                          obscureText: false),
                      const SizedBox(
                        height: 20,
                      ),
                      _title(title: S.of(context).password),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextFiled(
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          obscureText: true),
                      const SizedBox(
                        height: 20,
                      ),
                      _title(title: S.of(context).confirmPassword),
                      const SizedBox(
                        height: 10,
                      ),
                      LoginTextFiled(
                          focusNode: confirmFocusNode,
                          controller: confirmPasswordController,
                          obscureText: true),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: onRegisterBtnClick,
                  child: Container(
                    margin:
                        EdgeInsets.only(bottom: AppBar().preferredSize.height),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: colorPink,
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: _title(
                        title: S.of(context).register,
                        color: colorPrimaryDark,
                        fontFamily: fNSfUiSemiBold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(
      {required String title,
      String fontFamily = fNSfUiMedium,
      double fontSize = 15,
      Color color = Colors.white}) {
    return Text(
      title,
      style:
          TextStyle(color: color, fontFamily: fontFamily, fontSize: fontSize),
    );
  }

  void initSessionManager() async {
    await sessionManager.initPref();
  }

  void unFocusField() {
    nameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmFocusNode.unfocus();
    referralFocusNode.unfocus();
  }

  Future<void> onRegisterBtnClick() async {
    unFocusField();
    bool isValidation = isValid();
    if (isValidation) {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: colorTheme,
          ));
        },
      );
      await auth
          .createUserWithEmailAndPassword(
              email: emailController.text,
              password: confirmPasswordController.text)
          .then((value) async {
        await value.user?.sendEmailVerification();
        HashMap<String, String?> params = new HashMap();
        params[ConstRes.deviceToken] =
            sessionManager.getString(ConstRes.deviceToken);
        params[ConstRes.userEmail] = value.user?.email;
        params[ConstRes.fullName] = nameController.text;
        params[ConstRes.loginType] = KeyRes.email;
        params[ConstRes.userName] = value.user?.email != null
            ? value.user?.email!.split('@')[0]
            : value.user?.uid;
        params[ConstRes.identity] = value.user?.email ?? value.user?.uid;
        params[ConstRes.platform] = Platform.isAndroid ? "1" : "2";

        await ApiService().registerUser(params).then((value) async {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }).onError((FirebaseAuthException e, s) {
        CommonUI.showToast(msg: e.message.toString());
        Navigator.pop(context);
      });
    }
    setState(() {});
  }

  bool isValid() {
    int count = 0;
    if (nameController.text.isEmpty) {
      count++;
      CommonUI.showToast(msg: S.of(context).enterYourName);
      return false;
    }
    if (emailController.text.isEmpty) {
      count++;
      CommonUI.showToast(msg: S.of(context).enterYourMail);
      return false;
    }
    if (!emailController.text.isValidEmail()) {
      count++;
      CommonUI.showToast(msg: S.of(context).pleaseEnterValidEmail);
      return false;
    }
    if (passwordController.text.isEmpty) {
      count++;
      CommonUI.showToast(msg: S.of(context).pleaseEnterPassword);
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      count++;
      CommonUI.showToast(msg: S.of(context).enterReenterPassword);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      count++;
      CommonUI.showToast(msg: S.of(context).passwordDoseNotMatch);
      return false;
    }
    return count == 0 ? true : false;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

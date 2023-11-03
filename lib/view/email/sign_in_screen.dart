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
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:bubbly/view/email/sign_up_screen.dart';
import 'package:bubbly/view/email/widget/forgot_password.dart';
import 'package:bubbly/view/email/widget/login_text_filed.dart';
import 'package:bubbly/view/main/main_screen.dart';
import 'package:bubbly/view/webview/webview_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController resetPassController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode resetFocusNode = FocusNode();

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
                    '${S.of(context).signInFor} ${AppRes.appName}',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: fNSfUiSemiBold,
                        color: colorTextLight),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _title(title: S.of(context).enterYourMail),
                const SizedBox(
                  height: 10,
                ),
                LoginTextFiled(
                    focusNode: emailFocus,
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
                    focusNode: passwordFocus,
                    controller: passwordController,
                    obscureText: true),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleWidget(),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        emailController.clear();
                        passwordController.clear();
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ForgotPassword(
                              resetPassController: resetPassController,
                              onResetBtnClick: resetPassword,
                              resetFocusNode: resetFocusNode,
                            );
                          },
                        );
                      },
                      child: _title(title: S.of(context).forgotPassword),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: onLoginBtnClick,
                    child: Container(
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
                          title: S.of(context).login, color: colorPrimaryDark),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleWidget(),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ));
                      },
                      child: RichText(
                        text: TextSpan(
                          text: S.of(context).donTHaveAccount,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: fNSfUiLight),
                          children: <TextSpan>[
                            TextSpan(
                                text: S.of(context).signUp,
                                style: TextStyle(
                                    fontFamily: fNSfUiBold,
                                    color: colorPink,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    S.of(context).privacyPolicy,
                    style: TextStyle(
                      color: colorTextLight,
                      fontSize: 12,
                      fontFamily: fNSfUiLight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Text(S.of(context).termOfUse),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(2),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      child: Text(S.of(context).privacyPolicy),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(3),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
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

  final SessionManager sessionManager = SessionManager();

  //SIGN IN METHOD
  Future<UserCredential?> signIn(
      {required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      CommonUI.showToast(msg: e.message.toString());
      return null;
    }
  }

  void onLoginBtnClick() async {
    unFocusField();
    if (emailController.text.isEmpty) {
      return CommonUI.showToast(msg: S.of(context).pleaseEnterEmail);
    }
    if (!emailController.text.isValidEmail()) {
      return CommonUI.showToast(msg: S.of(context).pleaseEnterCorrectEmail);
    }
    if (passwordController.text.isEmpty) {
      return CommonUI.showToast(msg: S.of(context).pleaseEnterPassword);
    }
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: colorTheme,
          ),
        );
      },
    );
    signIn(email: emailController.text, password: passwordController.text)
        .then((value) async {
      if (value == null) return;
      if (value.user?.email == emailController.text) {
        if (value.user?.emailVerified == true) {
          sessionManager.saveString(KeyRes.password, passwordController.text);
          HashMap<String, String?> params = new HashMap();
          params[ConstRes.deviceToken] =
              sessionManager.getString(ConstRes.deviceToken);
          params[ConstRes.userEmail] = value.user?.email;
          params[ConstRes.fullName] = 'as';
          params[ConstRes.loginType] = KeyRes.email;
          params[ConstRes.userName] = value.user?.email != null
              ? value.user?.email!.split('@')[0]
              : value.user?.uid;
          params[ConstRes.identity] = value.user?.email ?? value.user?.uid;
          params[ConstRes.platform] = Platform.isAndroid ? "1" : "2";

          await ApiService().registerUser(params).then((value) async {
            Navigator.pop(context);
            if (value.status == 200) {
              CommonUI.showToast(msg: value.message.toString());
              Provider.of<MyLoading>(context, listen: false).setSelectedItem(0);
              Provider.of<MyLoading>(context, listen: false).setUser(value);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (Route<dynamic> route) => false);
            } else {
              CommonUI.showToast(msg: value.message.toString());
            }
          });
        } else {
          Navigator.pop(context);
          CommonUI.showToast(msg: S.of(context).pleaseVerifiedYourEmail);
        }
      } else {
        CommonUI.showToast(msg: S.of(context).emailNotFound);
      }
    });
  }

  void unFocusField() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  Future<void> resetPassword() async {
    resetFocusNode.unfocus();
    if (resetPassController.text.isEmpty) {
      CommonUI.showToast(msg: S.of(context).pleaseEnterEmail);
      return;
    } else if (!resetPassController.text.isValidEmail()) {
      CommonUI.showToast(msg: S.of(context).pleaseEnterValidEmailAddress);
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: resetPassController.text);
      resetPassController.clear();
      Navigator.pop(context);
      CommonUI.showToast(msg: S.of(context).emailSentSuccessfully);
    } on FirebaseAuthException catch (e) {
      CommonUI.showToast(msg: "${e.message}");
    }
  }

  void initSessionManager() async {
    await sessionManager.initPref();
  }
}

class CircleWidget extends StatelessWidget {
  const CircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorPink,
            blurRadius: 10,
            offset: Offset(1, 1),
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

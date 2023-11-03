import 'dart:io';

import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/main.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/key_res.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:flutter/material.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  String selectedLanguage = Platform.localeName.split('_')[0];
  SessionManager prefService = SessionManager();

  @override
  void initState() {
    prefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              height: 55,
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
                  Center(
                    child: Text(
                      S.of(context).languages,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.3,
            color: colorTextLight,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: index,
                    groupValue: value,
                    dense: true,
                    fillColor: MaterialStateProperty.all(colorTheme),
                    tileColor: colorPrimary,
                    onChanged: onLanguageChange,
                    title: Text(languages[index],
                        style: const TextStyle(
                            color: colorLightWhite,
                            fontFamily: fNSfUiSemiBold,
                            fontSize: 15)),
                    subtitle: Text(subLanguage[index],
                        style: TextStyle(
                          color: colorTextLight,
                          fontFamily: fNSfUiRegular,
                        )),
                  );
                },
                itemCount: languages.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  int? value = 0;
  List<String> languages = [
    'عربي',
    'dansk',
    'Nederlands',
    'English',
    'Français',
    'Deutsch',
    'Ελληνικά',
    'हिंदी',
    'bahasa Indonesia',
    'Italiano',
    '日本',
    '한국인',
    'Norsk Bokmal',
    'Polski',
    'Português',
    'Русский',
    '简体中文',
    'Español',
    'แบบไทย',
    'Türkçe',
    'Tiếng Việt',
  ];
  List<String> subLanguage = [
    'Arabic',
    'Danish',
    'Dutch',
    'English',
    'French',
    'German',
    'Greek',
    'Hindi',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Norwegian Bokmal',
    'Polish',
    'Portuguese',
    'Russian',
    'Simplified Chinese',
    'Spanish',
    'Thai',
    'Turkish',
    'Vietnamese',
  ];
  List languageCode = [
    'ar',
    'da',
    'nl',
    'en',
    'fr',
    'de',
    'el',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'nb',
    'pl',
    'pt',
    'ru',
    'zh',
    'es',
    'th',
    'tr',
    'vi',
  ];

  void onLanguageChange(int? value) async {
    this.value = value;
    prefService.saveString(KeyRes.languageCode, languageCode[value ?? 0]);
    selectedLanguage = languageCode[value ?? 0];
    MyApp.of(context)?.setLocale(selectedLanguage);
    // setState(() {});
  }

  void prefData() async {
    await prefService.initPref();
    selectedLanguage = prefService.getString(KeyRes.languageCode) ??
        Platform.localeName.split('_')[0];
    value = languageCode.indexOf(selectedLanguage);
    setState(() {});
  }
}

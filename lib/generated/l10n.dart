// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Data Not Found...!`
  String get dataNotFound {
    return Intl.message(
      'Data Not Found...!',
      name: 'dataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Sent Successfully`
  String get sentSuccessfully {
    return Intl.message(
      'Sent Successfully',
      name: 'sentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient Balance`
  String get insufficientBalance {
    return Intl.message(
      'Insufficient Balance',
      name: 'insufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure`
  String get areYouSure {
    return Intl.message(
      'Are you sure',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to go back?`
  String get doYouReallyWantToGoBack {
    return Intl.message(
      'Do you really want to go back?',
      name: 'doYouReallyWantToGoBack',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Too Large video`
  String get tooLargeVideo {
    return Intl.message(
      'Too Large video',
      name: 'tooLargeVideo',
      desc: '',
      args: [],
    );
  }

  /// `This video is greater than 50 mb\nPlease select another...`
  String get thisVideoIsGreaterThan50MbnpleaseSelectAnother {
    return Intl.message(
      'This video is greater than 50 mb\nPlease select another...',
      name: 'thisVideoIsGreaterThan50MbnpleaseSelectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Select another`
  String get selectAnother {
    return Intl.message(
      'Select another',
      name: 'selectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Too Long video`
  String get tooLongVideo {
    return Intl.message(
      'Too Long video',
      name: 'tooLongVideo',
      desc: '',
      args: [],
    );
  }

  /// `This video is greater than 1 min\nPlease select another...`
  String get thisVideoIsGreaterThan1MinnpleaseSelectAnother {
    return Intl.message(
      'This video is greater than 1 min\nPlease select another...',
      name: 'thisVideoIsGreaterThan1MinnpleaseSelectAnother',
      desc: '',
      args: [],
    );
  }

  /// `Which item would you like to select?\nSelect a item`
  String get whichItemWouldYouLikeToSelectnselectAItem {
    return Intl.message(
      'Which item would you like to select?\nSelect a item',
      name: 'whichItemWouldYouLikeToSelectnselectAItem',
      desc: '',
      args: [],
    );
  }

  /// `Images`
  String get images {
    return Intl.message(
      'Images',
      name: 'images',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `You block this user`
  String get youBlockThisUser {
    return Intl.message(
      'You block this user',
      name: 'youBlockThisUser',
      desc: '',
      args: [],
    );
  }

  /// `Type something...!`
  String get typeSomething {
    return Intl.message(
      'Type something...!',
      name: 'typeSomething',
      desc: '',
      args: [],
    );
  }

  /// `Send Media`
  String get sendMedia {
    return Intl.message(
      'Send Media',
      name: 'sendMedia',
      desc: '',
      args: [],
    );
  }

  /// `Write Message`
  String get writeMessage {
    return Intl.message(
      'Write Message',
      name: 'writeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Report User`
  String get reportUser {
    return Intl.message(
      'Report User',
      name: 'reportUser',
      desc: '',
      args: [],
    );
  }

  /// `UnBlock User`
  String get unblockUser {
    return Intl.message(
      'UnBlock User',
      name: 'unblockUser',
      desc: '',
      args: [],
    );
  }

  /// `Block User`
  String get blockUser {
    return Intl.message(
      'Block User',
      name: 'blockUser',
      desc: '',
      args: [],
    );
  }

  /// `Failed Video`
  String get failedVideo {
    return Intl.message(
      'Failed Video',
      name: 'failedVideo',
      desc: '',
      args: [],
    );
  }

  /// `You are block from other`
  String get youAreBlockFromOther {
    return Intl.message(
      'You are block from other',
      name: 'youAreBlockFromOther',
      desc: '',
      args: [],
    );
  }

  /// `Delete message`
  String get deleteMessage {
    return Intl.message(
      'Delete message',
      name: 'deleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this message ?`
  String get areYouSureYouWantToDeleteThisMessage {
    return Intl.message(
      'Are you sure you want to delete this message ?',
      name: 'areYouSureYouWantToDeleteThisMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Leave your comment...`
  String get leaveYourComment {
    return Intl.message(
      'Leave your comment...',
      name: 'leaveYourComment',
      desc: '',
      args: [],
    );
  }

  /// `Enter comment first`
  String get enterCommentFirst {
    return Intl.message(
      'Enter comment first',
      name: 'enterCommentFirst',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mail on which you have created \nan account. We will send a link \nto reset your password`
  String get enterYourMailOnWhichYouHaveCreatedNanAccount {
    return Intl.message(
      'Enter your mail on which you have created \nan account. We will send a link \nto reset your password',
      name: 'enterYourMailOnWhichYouHaveCreatedNanAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up for`
  String get signUpFor {
    return Intl.message(
      'Sign Up for',
      name: 'signUpFor',
      desc: '',
      args: [],
    );
  }

  /// `Create a profile, follow other creators\nbuild your fan following by creating\nyour own videos and earn reward !`
  String get createAProfileFollowOtherCreatorsnbuildYourFanFollowingBy {
    return Intl.message(
      'Create a profile, follow other creators\nbuild your fan following by creating\nyour own videos and earn reward !',
      name: 'createAProfileFollowOtherCreatorsnbuildYourFanFollowingBy',
      desc: '',
      args: [],
    );
  }

  /// `Sing in With Apple`
  String get singInWithApple {
    return Intl.message(
      'Sing in With Apple',
      name: 'singInWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Sing in With Email`
  String get singInWithEmail {
    return Intl.message(
      'Sing in With Email',
      name: 'singInWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sing in With Google`
  String get singInWithGoogle {
    return Intl.message(
      'Sing in With Google',
      name: 'singInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Term of use`
  String get termOfUse {
    return Intl.message(
      'Term of use',
      name: 'termOfUse',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sign in for`
  String get signInFor {
    return Intl.message(
      'Sign in for',
      name: 'signInFor',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mail`
  String get enterYourMail {
    return Intl.message(
      'Enter your mail',
      name: 'enterYourMail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Don't have account`
  String get donTHaveAccount {
    return Intl.message(
      'Don\'t have account',
      name: 'donTHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter email...!`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please Enter email...!',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Correct email...!`
  String get pleaseEnterCorrectEmail {
    return Intl.message(
      'Please Enter Correct email...!',
      name: 'pleaseEnterCorrectEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Password...!`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please Enter Password...!',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please verified your email...!`
  String get pleaseVerifiedYourEmail {
    return Intl.message(
      'Please verified your email...!',
      name: 'pleaseVerifiedYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email Not Found`
  String get emailNotFound {
    return Intl.message(
      'Email Not Found',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter valid email address`
  String get pleaseEnterValidEmailAddress {
    return Intl.message(
      'Please Enter valid email address',
      name: 'pleaseEnterValidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Email sent Successfully...`
  String get emailSentSuccessfully {
    return Intl.message(
      'Email sent Successfully...',
      name: 'emailSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Name`
  String get enterYourName {
    return Intl.message(
      'Enter your Name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email...!`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter valid email...!',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter re-enter password`
  String get enterReenterPassword {
    return Intl.message(
      'Enter re-enter password',
      name: 'enterReenterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password dose not match...!`
  String get passwordDoseNotMatch {
    return Intl.message(
      'Password dose not match...!',
      name: 'passwordDoseNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Lives`
  String get lives {
    return Intl.message(
      'Lives',
      name: 'lives',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get following {
    return Intl.message(
      'Following',
      name: 'following',
      desc: '',
      args: [],
    );
  }

  /// `Followers`
  String get followers {
    return Intl.message(
      'Followers',
      name: 'followers',
      desc: '',
      args: [],
    );
  }

  /// `Popular Creator`
  String get popularCreator {
    return Intl.message(
      'Popular Creator',
      name: 'popularCreator',
      desc: '',
      args: [],
    );
  }

  /// `Follow some creators to\n watch their videos.`
  String get followSomeCreatorsTonWatchTheirVideos {
    return Intl.message(
      'Follow some creators to\n watch their videos.',
      name: 'followSomeCreatorsTonWatchTheirVideos',
      desc: '',
      args: [],
    );
  }

  /// `Please Accept`
  String get pleaseAccept {
    return Intl.message(
      'Please Accept',
      name: 'pleaseAccept',
      desc: '',
      args: [],
    );
  }

  /// `Please check these Privacy Policy and Terms Of Use before using the app and accept it.`
  String get pleaseCheckThesePrivacyPolicyAndTermsOfUseBefore {
    return Intl.message(
      'Please check these Privacy Policy and Terms Of Use before using the app and accept it.',
      name: 'pleaseCheckThesePrivacyPolicyAndTermsOfUseBefore',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message(
      'Follow',
      name: 'follow',
      desc: '',
      args: [],
    );
  }

  /// `Your live stream has been ended!\nBelow is a summary of it.`
  String get yourLiveStreamHasBeenEndednbelowIsASummaryOf {
    return Intl.message(
      'Your live stream has been ended!\nBelow is a summary of it.',
      name: 'yourLiveStreamHasBeenEndednbelowIsASummaryOf',
      desc: '',
      args: [],
    );
  }

  /// `Stream for`
  String get streamFor {
    return Intl.message(
      'Stream for',
      name: 'streamFor',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get users {
    return Intl.message(
      'Users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `Collected`
  String get collected {
    return Intl.message(
      'Collected',
      name: 'collected',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Live`
  String get live {
    return Intl.message(
      'Live',
      name: 'live',
      desc: '',
      args: [],
    );
  }

  /// `Go Live`
  String get goLive {
    return Intl.message(
      'Go Live',
      name: 'goLive',
      desc: '',
      args: [],
    );
  }

  /// `No User Live`
  String get noUserLive {
    return Intl.message(
      'No User Live',
      name: 'noUserLive',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `End User License Agreement`
  String get endUserLicenseAgreement {
    return Intl.message(
      'End User License Agreement',
      name: 'endUserLicenseAgreement',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message(
      'Discover',
      name: 'discover',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get favourite {
    return Intl.message(
      'Favourite',
      name: 'favourite',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Delete this chat`
  String get deleteThisChat {
    return Intl.message(
      'Delete this chat',
      name: 'deleteThisChat',
      desc: '',
      args: [],
    );
  }

  /// `Message will only be removed from this device\nAre you sure?`
  String get messageWillOnlyBeRemovedFromThisDevicenareYouSure {
    return Intl.message(
      'Message will only be removed from this device\nAre you sure?',
      name: 'messageWillOnlyBeRemovedFromThisDevicenareYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Delete Chat`
  String get deleteChat {
    return Intl.message(
      'Delete Chat',
      name: 'deleteChat',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Choose Category`
  String get chooseCategory {
    return Intl.message(
      'Choose Category',
      name: 'chooseCategory',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Profile Category`
  String get profileCategory {
    return Intl.message(
      'Profile Category',
      name: 'profileCategory',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Present yourself`
  String get presentYourself {
    return Intl.message(
      'Present yourself',
      name: 'presentYourself',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `facebook`
  String get facebook {
    return Intl.message(
      'facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `instagram`
  String get instagram {
    return Intl.message(
      'instagram',
      name: 'instagram',
      desc: '',
      args: [],
    );
  }

  /// `youtube`
  String get youtube {
    return Intl.message(
      'youtube',
      name: 'youtube',
      desc: '',
      args: [],
    );
  }

  /// `Update profile successfully..!`
  String get updateProfileSuccessfully {
    return Intl.message(
      'Update profile successfully..!',
      name: 'updateProfileSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Remove post`
  String get removePost {
    return Intl.message(
      'Remove post',
      name: 'removePost',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure \nwant to remove post ?`
  String get areYouSureNwantToRemovePost {
    return Intl.message(
      'Are you sure \nwant to remove post ?',
      name: 'areYouSureNwantToRemovePost',
      desc: '',
      args: [],
    );
  }

  /// `Share Profile`
  String get shareProfile {
    return Intl.message(
      'Share Profile',
      name: 'shareProfile',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Invalid url`
  String get invalidUrl {
    return Intl.message(
      'Invalid url',
      name: 'invalidUrl',
      desc: '',
      args: [],
    );
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message(
      'Unfollow',
      name: 'unfollow',
      desc: '',
      args: [],
    );
  }

  /// `File saved successfully...!`
  String get fileSavedSuccessfully {
    return Intl.message(
      'File saved successfully...!',
      name: 'fileSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save Code`
  String get saveCode {
    return Intl.message(
      'Save Code',
      name: 'saveCode',
      desc: '',
      args: [],
    );
  }

  /// `Scan to follow me`
  String get scanToFollowMe {
    return Intl.message(
      'Scan to follow me',
      name: 'scanToFollowMe',
      desc: '',
      args: [],
    );
  }

  /// `My Code`
  String get myCode {
    return Intl.message(
      'My Code',
      name: 'myCode',
      desc: '',
      args: [],
    );
  }

  /// `Scan Qr Code`
  String get scanQrCode {
    return Intl.message(
      'Scan Qr Code',
      name: 'scanQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR code to see profile`
  String get scanQrCodeToSeeProfile {
    return Intl.message(
      'Scan QR code to see profile',
      name: 'scanQrCodeToSeeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Redeem shortzz`
  String get redeemShortzz {
    return Intl.message(
      'Redeem shortzz',
      name: 'redeemShortzz',
      desc: '',
      args: [],
    );
  }

  /// `you have`
  String get youHave {
    return Intl.message(
      'you have',
      name: 'youHave',
      desc: '',
      args: [],
    );
  }

  /// `Select Method`
  String get selectMethod {
    return Intl.message(
      'Select Method',
      name: 'selectMethod',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Mail / Mobile`
  String get mailMobile {
    return Intl.message(
      'Mail / Mobile',
      name: 'mailMobile',
      desc: '',
      args: [],
    );
  }

  /// `Please select payment method...!`
  String get pleaseSelectPaymentMethod {
    return Intl.message(
      'Please select payment method...!',
      name: 'pleaseSelectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please enter account...!`
  String get pleaseEnterAccount {
    return Intl.message(
      'Please enter account...!',
      name: 'pleaseEnterAccount',
      desc: '',
      args: [],
    );
  }

  /// `Redeem`
  String get redeem {
    return Intl.message(
      'Redeem',
      name: 'redeem',
      desc: '',
      args: [],
    );
  }

  /// `Redeem requests are processed with in 10 days\nand be prepared that your account comply with our\nterms and policy. you can check more below.`
  String get redeemRequestsAreProcessedWithIn10DaysnandBePrepared {
    return Intl.message(
      'Redeem requests are processed with in 10 days\nand be prepared that your account comply with our\nterms and policy. you can check more below.',
      name: 'redeemRequestsAreProcessedWithIn10DaysnandBePrepared',
      desc: '',
      args: [],
    );
  }

  /// `Policy center`
  String get policyCenter {
    return Intl.message(
      'Policy center',
      name: 'policyCenter',
      desc: '',
      args: [],
    );
  }

  /// `Select reason`
  String get selectReason {
    return Intl.message(
      'Select reason',
      name: 'selectReason',
      desc: '',
      args: [],
    );
  }

  /// `How it hurts you`
  String get howItHurtsYou {
    return Intl.message(
      'How it hurts you',
      name: 'howItHurtsYou',
      desc: '',
      args: [],
    );
  }

  /// `Explain briefly`
  String get explainBriefly {
    return Intl.message(
      'Explain briefly',
      name: 'explainBriefly',
      desc: '',
      args: [],
    );
  }

  /// `Contact detail (Mail or Mobile)`
  String get contactDetailMailOrMobile {
    return Intl.message(
      'Contact detail (Mail or Mobile)',
      name: 'contactDetailMailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Mail or phone`
  String get mailOrPhone {
    return Intl.message(
      'Mail or phone',
      name: 'mailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please select reason`
  String get pleaseSelectReason {
    return Intl.message(
      'Please select reason',
      name: 'pleaseSelectReason',
      desc: '',
      args: [],
    );
  }

  /// `Please enter description`
  String get pleaseEnterDescription {
    return Intl.message(
      'Please enter description',
      name: 'pleaseEnterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please enter contact detail`
  String get pleaseEnterContactDetail {
    return Intl.message(
      'Please enter contact detail',
      name: 'pleaseEnterContactDetail',
      desc: '',
      args: [],
    );
  }

  /// `By clicking this submit button,you agree that\nyou are taking all the responsibilities of all the\nprocess that may be done by us or the content\nuploader. Click the link below to knowmore\nabout that`
  String get byClickingThisSubmitButtonyouAgreeThatnyouAreTakingAll {
    return Intl.message(
      'By clicking this submit button,you agree that\nyou are taking all the responsibilities of all the\nprocess that may be done by us or the content\nuploader. Click the link below to knowmore\nabout that',
      name: 'byClickingThisSubmitButtonyouAgreeThatnyouAreTakingAll',
      desc: '',
      args: [],
    );
  }

  /// `Fans`
  String get fans {
    return Intl.message(
      'Fans',
      name: 'fans',
      desc: '',
      args: [],
    );
  }

  /// `Send shortzz`
  String get sendShortzz {
    return Intl.message(
      'Send shortzz',
      name: 'sendShortzz',
      desc: '',
      args: [],
    );
  }

  /// `Creator will be notified\nabout your love`
  String get creatorWillBeNotifiednaboutYourLove {
    return Intl.message(
      'Creator will be notified\nabout your love',
      name: 'creatorWillBeNotifiednaboutYourLove',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notify me`
  String get notifyMe {
    return Intl.message(
      'Notify me',
      name: 'notifyMe',
      desc: '',
      args: [],
    );
  }

  /// `My QR Code`
  String get myQrCode {
    return Intl.message(
      'My QR Code',
      name: 'myQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Minimum follower`
  String get minimumFollower {
    return Intl.message(
      'Minimum follower',
      name: 'minimumFollower',
      desc: '',
      args: [],
    );
  }

  /// `Request verification`
  String get requestVerification {
    return Intl.message(
      'Request verification',
      name: 'requestVerification',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Terms of use`
  String get termsOfUse {
    return Intl.message(
      'Terms of use',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `All of your data: including Posts,\n Likes, Follows and everything which is\n connected to your identity, will be deleted \nfrom our platform. This actions can't be undone.`
  String get allOfYourDataIncludingPostsnLikesFollowsAndEverything {
    return Intl.message(
      'All of your data: including Posts,\n Likes, Follows and everything which is\n connected to your identity, will be deleted \nfrom our platform. This actions can\'t be undone.',
      name: 'allOfYourDataIncludingPostsnLikesFollowsAndEverything',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Do yo really \nwant to log out ?`
  String get doYoReallyNwantToLogOut {
    return Intl.message(
      'Do yo really \nwant to log out ?',
      name: 'doYoReallyNwantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Sound Videos`
  String get soundVideos {
    return Intl.message(
      'Sound Videos',
      name: 'soundVideos',
      desc: '',
      args: [],
    );
  }

  /// `UnFavourite`
  String get unfavourite {
    return Intl.message(
      'UnFavourite',
      name: 'unfavourite',
      desc: '',
      args: [],
    );
  }

  /// `Use this sound`
  String get useThisSound {
    return Intl.message(
      'Use this sound',
      name: 'useThisSound',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get uploadVideo {
    return Intl.message(
      'Upload Video',
      name: 'uploadVideo',
      desc: '',
      args: [],
    );
  }

  /// `Describe`
  String get describe {
    return Intl.message(
      'Describe',
      name: 'describe',
      desc: '',
      args: [],
    );
  }

  /// `Awesome caption`
  String get awesomeCaption {
    return Intl.message(
      'Awesome caption',
      name: 'awesomeCaption',
      desc: '',
      args: [],
    );
  }

  /// `Post Upload Successfully`
  String get postUploadSuccessfully {
    return Intl.message(
      'Post Upload Successfully',
      name: 'postUploadSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Your photo(Holding your ID card)`
  String get yourPhotoholdingYourIdCard {
    return Intl.message(
      'Your photo(Holding your ID card)',
      name: 'yourPhotoholdingYourIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Capture`
  String get capture {
    return Intl.message(
      'Capture',
      name: 'capture',
      desc: '',
      args: [],
    );
  }

  /// `Photo of ID(Clear Photo)`
  String get photoOfIdclearPhoto {
    return Intl.message(
      'Photo of ID(Clear Photo)',
      name: 'photoOfIdclearPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Attach`
  String get attach {
    return Intl.message(
      'Attach',
      name: 'attach',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get idNumber {
    return Intl.message(
      'ID Number',
      name: 'idNumber',
      desc: '',
      args: [],
    );
  }

  /// `Name On ID`
  String get nameOnId {
    return Intl.message(
      'Name On ID',
      name: 'nameOnId',
      desc: '',
      args: [],
    );
  }

  /// `Same as ID`
  String get sameAsId {
    return Intl.message(
      'Same as ID',
      name: 'sameAsId',
      desc: '',
      args: [],
    );
  }

  /// `Full Address`
  String get fullAddress {
    return Intl.message(
      'Full Address',
      name: 'fullAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please capture image...!`
  String get pleaseCaptureImage {
    return Intl.message(
      'Please capture image...!',
      name: 'pleaseCaptureImage',
      desc: '',
      args: [],
    );
  }

  /// `Please attach your id card...!`
  String get pleaseAttachYourIdCard {
    return Intl.message(
      'Please attach your id card...!',
      name: 'pleaseAttachYourIdCard',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your id number...!`
  String get pleaseEnterYourIdNumber {
    return Intl.message(
      'Please enter your id number...!',
      name: 'pleaseEnterYourIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name...!`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name...!',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your full address...!`
  String get pleaseEnterYourFullAddress {
    return Intl.message(
      'Please enter your full address...!',
      name: 'pleaseEnterYourFullAddress',
      desc: '',
      args: [],
    );
  }

  /// `Request for verification successfully...!`
  String get requestForVerificationSuccessfully {
    return Intl.message(
      'Request for verification successfully...!',
      name: 'requestForVerificationSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Whenever you upload video`
  String get wheneverYouUploadVideo {
    return Intl.message(
      'Whenever you upload video',
      name: 'wheneverYouUploadVideo',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Total Earning`
  String get totalEarning {
    return Intl.message(
      'Total Earning',
      name: 'totalEarning',
      desc: '',
      args: [],
    );
  }

  /// `Total Spending`
  String get totalSpending {
    return Intl.message(
      'Total Spending',
      name: 'totalSpending',
      desc: '',
      args: [],
    );
  }

  /// `Passbook`
  String get passbook {
    return Intl.message(
      'Passbook',
      name: 'passbook',
      desc: '',
      args: [],
    );
  }

  /// `From your fans`
  String get fromYourFans {
    return Intl.message(
      'From your fans',
      name: 'fromYourFans',
      desc: '',
      args: [],
    );
  }

  /// `Purchased`
  String get purchased {
    return Intl.message(
      'Purchased',
      name: 'purchased',
      desc: '',
      args: [],
    );
  }

  /// `Rewarding Actions`
  String get rewardingActions {
    return Intl.message(
      'Rewarding Actions',
      name: 'rewardingActions',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient redeem points`
  String get insufficientRedeemPoints {
    return Intl.message(
      'Insufficient redeem points',
      name: 'insufficientRedeemPoints',
      desc: '',
      args: [],
    );
  }

  /// `Request Redeem`
  String get requestRedeem {
    return Intl.message(
      'Request Redeem',
      name: 'requestRedeem',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message(
      'Preview',
      name: 'preview',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'da'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'nb'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:bubbly/modal/agora/agora.dart';
import 'package:bubbly/modal/agora/agora_token.dart';
import 'package:bubbly/modal/comment/comment.dart';
import 'package:bubbly/modal/explore/explore_hash_tag.dart';
import 'package:bubbly/modal/file_path/file_path.dart';
import 'package:bubbly/modal/followers/follower_following_data.dart';
import 'package:bubbly/modal/notificaion/notification.dart';
import 'package:bubbly/modal/plan/coin_plans.dart';
import 'package:bubbly/modal/profileCategory/profile_category.dart';
import 'package:bubbly/modal/rest/rest_response.dart';
import 'package:bubbly/modal/search/search_user.dart';
import 'package:bubbly/modal/setting/setting.dart';
import 'package:bubbly/modal/single/single_post.dart';
import 'package:bubbly/modal/sound/fav/favourite_music.dart';
import 'package:bubbly/modal/sound/sound.dart';
import 'package:bubbly/modal/user/user.dart';
import 'package:bubbly/modal/uservideo/user_video.dart';
import 'package:bubbly/modal/wallet/my_wallet.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:firebase_auth/firebase_auth.dart' as FireBaseAuth1;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var client = http.Client();

  Future<User> registerUser(HashMap<String, String?> params) async {
    final response = await client.post(
      Uri.parse(ConstRes.registerUser),
      body: params,
      headers: {ConstRes.uniqueKey: ConstRes.apiKey},
    );
    final responseJson = jsonDecode(response.body);
    SessionManager sessionManager = SessionManager();
    await sessionManager.initPref();
    // print(jsonEncode(User.fromJson(responseJson)));
    sessionManager.saveUser(
      jsonEncode(
        User.fromJson(responseJson),
      ),
    );
    return User.fromJson(responseJson);
  }

  Future<UserVideo> getUserVideos(
      String star, String limit, String? userId, int type) async {
    final response = await client.post(
      Uri.parse(
          type == 0 ? ConstRes.getUserVideos : ConstRes.getUserLikesVideos),
      body: {
        ConstRes.start: star,
        ConstRes.limit: limit,
        ConstRes.userId: userId,
        ConstRes.myUserId: SessionManager.userId.toString()
      },
      headers: {ConstRes.uniqueKey: ConstRes.apiKey},
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return UserVideo.fromJson(responseJson);
  }

  Future<UserVideo> getPostList(
      String start, String limit, String userId, String type) async {
    final response = await client.post(
      Uri.parse(ConstRes.getPostList),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
        ConstRes.userId: userId,
        ConstRes.type: type,
      },
      headers: {ConstRes.uniqueKey: ConstRes.apiKey},
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return UserVideo.fromJson(responseJson);
  }

  Future<RestResponse> likeUnlikePost(String postId) async {
    // print(SessionManager.accessToken);
    final response = await client.post(
      Uri.parse(ConstRes.likeUnlikePost),
      body: {
        ConstRes.postId: postId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return RestResponse.fromJson(responseJson);
  }

  Future<Comment> getCommentByPostId(
      String start, String limit, String postId) async {
    final response = await client.post(
      Uri.parse(ConstRes.getCommentByPostId),
      body: {
        ConstRes.postId: postId,
        ConstRes.start: start,
        ConstRes.limit: limit,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return Comment.fromJson(responseJson);
  }

  Future<RestResponse> addComment(String comment, String postId) async {
    final response = await client.post(
      Uri.parse(ConstRes.addComment),
      body: {
        ConstRes.postId: postId,
        ConstRes.comment: comment,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteComment(String commentID) async {
    final response = await client.post(
      Uri.parse(ConstRes.deleteComment),
      body: {
        ConstRes.commentId: commentID,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<UserVideo> getPostByHashTag(
      String start, String limit, String? hashTag) async {
    // print(hashTag);
    final response = await client.post(
      Uri.parse(ConstRes.videosByHashTag),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
        ConstRes.userId: SessionManager.userId.toString(),
        ConstRes.hashTag: hashTag,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );
    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return UserVideo.fromJson(responseJson);
  }

  Future<UserVideo> getPostBySoundId(
      String start, String limit, String? soundId) async {
    final response = await client.post(
      Uri.parse(ConstRes.getPostBySoundId),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
        ConstRes.userId: SessionManager.userId.toString(),
        ConstRes.soundId: soundId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );
    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return UserVideo.fromJson(responseJson);
  }

  Future<RestResponse> sendCoin(String coin, String toUserId) async {
    final response = await client.post(
      Uri.parse(ConstRes.sendCoin),
      body: {
        ConstRes.coin: coin,
        ConstRes.toUserId: toUserId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    await getProfile(SessionManager.userId.toString());
    return RestResponse.fromJson(responseJson);
  }

  Future<ExploreHashTag> getExploreHashTag(String start, String limit) async {
    final response = await client.post(
      Uri.parse(ConstRes.getExploreHashTag),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return ExploreHashTag.fromJson(responseJson);
  }

  Future<SearchUser> getSearchUser(
      String start, String limit, String keyWord) async {
    client = http.Client();
    final response = await client.post(
      Uri.parse(ConstRes.getUserSearchPostList),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
        ConstRes.keyWord: keyWord,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return SearchUser.fromJson(responseJson);
  }

  Future<UserVideo> getSearchPostList(
      String start, String limit, String? userId, String? keyWord) async {
    client = http.Client();
    // print(
    //     'UserId : $userId, Start : $start, Limit : $limit, Keyword : $keyWord');
    final response = await client.post(
      Uri.parse(ConstRes.getSearchPostList),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
        ConstRes.userId: userId,
        ConstRes.keyWord: keyWord,
      },
      headers: {ConstRes.uniqueKey: ConstRes.apiKey},
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return UserVideo.fromJson(responseJson);
  }

  Future<UserNotifications> getNotificationList(
      String start, String limit) async {
    client = http.Client();
    // print(SessionManager.accessToken);
    final response = await client.post(
      Uri.parse(ConstRes.getNotificationList),
      body: {
        ConstRes.start: start,
        ConstRes.limit: limit,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    print(response.statusCode);
    final responseJson = jsonDecode(response.body);
    return UserNotifications.fromJson(responseJson);
  }

  Future<RestResponse> setNotificationSettings(String? deviceToken) async {
    client = http.Client();
    final response = await client.post(
      Uri.parse(ConstRes.setNotificationSettings),
      body: {
        ConstRes.deviceToken: deviceToken,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  // Future<CoinRate> getCoinRateList() async {
  //   client = http.Client();
  //   final response = await client.get(
  //     Uri.parse(ConstRes.getCoinRateList),
  //     headers: {
  //       ConstRes.uniqueKey: ConstRes.apiKey,
  //       ConstRes.authorization: SessionManager.accessToken!,
  //     },
  //   );
  //   final responseJson = jsonDecode(response.body);
  //   return CoinRate.fromJson(responseJson);
  // }

  // Future<RewardingActions> getRewardingActions() async {
  //   client = http.Client();
  //   final response = await client.get(
  //     Uri.parse(ConstRes.getRewardingActionList),
  //     headers: {
  //       ConstRes.uniqueKey: ConstRes.apiKey,
  //       ConstRes.authorization: SessionManager.accessToken!,
  //     },
  //   );
  //   print(response.body);
  //   final responseJson = jsonDecode(response.body);
  //   return RewardingActions.fromJson(responseJson);
  // }

  Future<MyWallet> getMyWalletCoin() async {
    client = http.Client();
    final response = await client.get(
      Uri.parse(ConstRes.getMyWalletCoin),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    final responseJson = jsonDecode(response.body);
    return MyWallet.fromJson(responseJson);
  }

  Future<RestResponse> redeemRequest(String amount, String redeemRequestType,
      String account, String coin) async {
    client = http.Client();
    final response = await client.post(
      Uri.parse(ConstRes.redeemRequest),
      body: {
        ConstRes.amount: amount,
        ConstRes.redeemRequestType: redeemRequestType,
        ConstRes.account: account,
        ConstRes.coin: coin,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    final responseJson = jsonDecode(response.body);
    await getProfile(SessionManager.userId.toString());
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> verifyRequest(String idNumber, String name,
      String address, File? photoIdImage, File? photoWithIdImage) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ConstRes.verifyRequest),
    );
    request.headers[ConstRes.uniqueKey] = ConstRes.apiKey;
    request.headers[ConstRes.authorization] = SessionManager.accessToken!;
    request.fields[ConstRes.idNumber] = idNumber;
    request.fields[ConstRes.name] = name;
    request.fields[ConstRes.address] = address;
    if (photoIdImage != null) {
      request.files.add(
        http.MultipartFile(ConstRes.photoIdImage,
            photoIdImage.readAsBytes().asStream(), photoIdImage.lengthSync(),
            filename: photoIdImage.path.split("/").last),
      );
    }
    if (photoWithIdImage != null) {
      request.files.add(
        http.MultipartFile(
            ConstRes.photoWithIdImage,
            photoWithIdImage.readAsBytes().asStream(),
            photoWithIdImage.lengthSync(),
            filename: photoWithIdImage.path.split("/").last),
      );
    }

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    await getProfile(SessionManager.userId.toString());
    return RestResponse.fromJson(jsonDecode(respStr));
  }

  Future<User> getProfile(String? userId) async {
    Map<String, dynamic> map = {};
    if (SessionManager.userId != -1) {
      map[ConstRes.myUserId] = SessionManager.userId.toString();
    }
    map[ConstRes.userId] = userId;
    final response = await client.post(
      Uri.parse(ConstRes.getProfile),
      body: map,
      headers: {ConstRes.uniqueKey: ConstRes.apiKey},
    );
    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    if (userId == SessionManager.userId.toString()) {
      SessionManager sessionManager = SessionManager();
      await sessionManager.initPref();
      // print(response.body);
      User user = User.fromJson(responseJson);
      if (SessionManager.accessToken != null &&
          SessionManager.accessToken!.isNotEmpty) {
        user.data?.setToken(SessionManager.accessToken);
      }
      sessionManager.saveUser(jsonEncode(user));
    }

    // print(response.body);
    return User.fromJson(responseJson);
  }

  Future<ProfileCategory> getProfileCategoryList() async {
    client = http.Client();
    final response = await client.get(
      Uri.parse(ConstRes.getProfileCategoryList),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return ProfileCategory.fromJson(responseJson);
  }

  Future<User> updateProfile(
    String fullName,
    String userName,
    String userEmail,
    String bio,
    String fbUrl,
    String instaUrl,
    String youtubeUrl,
    String profileCategory,
    File? profileImage,
  ) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ConstRes.updateProfile),
    );
    request.headers[ConstRes.uniqueKey] = ConstRes.apiKey;
    request.headers[ConstRes.authorization] = SessionManager.accessToken!;
    request.fields[ConstRes.fullName] = fullName;
    request.fields[ConstRes.userName] = userName;
    request.fields[ConstRes.userEmail] = userEmail;
    request.fields[ConstRes.bio] = bio;
    request.fields[ConstRes.fbUrl] = fbUrl;
    request.fields[ConstRes.instaUrl] = instaUrl;
    request.fields[ConstRes.youtubeUrl] = youtubeUrl;
    if (profileCategory.isNotEmpty) {
      request.fields[ConstRes.profileCategory] = profileCategory;
    }
    if (profileImage != null) {
      request.files.add(
        http.MultipartFile(ConstRes.userProfile,
            profileImage.readAsBytes().asStream(), profileImage.lengthSync(),
            filename: profileImage.path.split("/").last),
      );
    }

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    User user = User.fromJson(jsonDecode(respStr));
    if (user.data!.userId.toString() == SessionManager.userId.toString()) {
      SessionManager sessionManager = SessionManager();
      // print(respStr);
      await sessionManager.initPref();
      if (SessionManager.accessToken != null &&
          SessionManager.accessToken!.isNotEmpty) {
        user.data!.setToken(SessionManager.accessToken);
      }
      sessionManager.saveUser(jsonEncode(user));
    }
    return User.fromJson(jsonDecode(respStr));
  }

  Future<RestResponse> followUnFollowUser(String toUserId) async {
    final response = await client.post(
      Uri.parse(ConstRes.followUnFollowPost),
      body: {
        ConstRes.toUserId: toUserId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return RestResponse.fromJson(responseJson);
  }

  Future<FollowerFollowingData> getFollowersList(
      String userId, String start, String count, int type) async {
    final response = await client.post(
      Uri.parse(
          type == 0 ? ConstRes.getFollowerList : ConstRes.getFollowingList),
      body: {
        ConstRes.userId: userId,
        ConstRes.start: start,
        ConstRes.limit: count,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return FollowerFollowingData.fromJson(responseJson);
  }

  Future<Sound> getSoundList() async {
    final response = await client.get(
      Uri.parse(ConstRes.getSoundList),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    final responseJson = jsonDecode(response.body);
    // print(responseJson);
    return Sound.fromJson(responseJson);
  }

  Future<FavouriteMusic> getFavouriteSoundList() async {
    SessionManager sessionManager = new SessionManager();
    await sessionManager.initPref();
    final response = await client.post(
      Uri.parse(ConstRes.getFavouriteSoundList),
      body: jsonEncode(<String, List<String>>{
        'sound_ids': sessionManager.getFavouriteMusic(),
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return FavouriteMusic.fromJson(responseJson);
  }

  Future<RestResponse> addPost({
    required String postDescription,
    String? postHashTag,
    required String isOrignalSound,
    String? soundTitle,
    String? duration,
    String? singer,
    String? soundId,
    File? postVideo,
    File? thumbnail,
    File? postSound,
    File? soundImage,
  }) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ConstRes.addPost),
    );
    request.headers[ConstRes.uniqueKey] = ConstRes.apiKey;
    request.headers[ConstRes.authorization] = SessionManager.accessToken!;
    if (postDescription.isNotEmpty) {
      request.fields[ConstRes.postDescription] = postDescription;
    }
    if (postHashTag != null || postHashTag!.isNotEmpty) {
      request.fields[ConstRes.postHashTag] =
          postHashTag.isEmpty ? '' : postHashTag;
    }
    request.fields[ConstRes.isOrignalSound] = isOrignalSound;
    if (isOrignalSound == '1') {
      request.fields[ConstRes.soundTitle] = soundTitle!;
      request.fields[ConstRes.duration] = duration!;
      request.fields[ConstRes.singer] = singer!;
      if (postSound != null) {
        request.files.add(
          http.MultipartFile(ConstRes.postSound,
              postSound.readAsBytes().asStream(), postSound.lengthSync(),
              filename: postSound.path.split("/").last),
        );
      }
      if (soundImage != null) {
        request.files.add(
          http.MultipartFile(ConstRes.soundImage,
              soundImage.readAsBytes().asStream(), soundImage.lengthSync(),
              filename: soundImage.path.split("/").last),
        );
      }
    } else {
      request.fields[ConstRes.soundId] = soundId!;
    }
    if (postVideo != null) {
      request.files.add(
        http.MultipartFile(ConstRes.postVideo,
            postVideo.readAsBytes().asStream(), postVideo.lengthSync(),
            filename: postVideo.path.split("/").last),
      );
    }
    if (thumbnail != null) {
      request.files.add(
        http.MultipartFile(ConstRes.postImage,
            thumbnail.readAsBytes().asStream(), thumbnail.lengthSync(),
            filename: thumbnail.path.split("/").last),
      );
    }

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    addCoin();
    return RestResponse.fromJson(responseJson);
  }

  Future<FavouriteMusic> getSearchSoundList(String keyword) async {
    client = http.Client();
    SessionManager sessionManager = new SessionManager();
    await sessionManager.initPref();
    final response = await client.post(
      Uri.parse(ConstRes.getSearchSoundList),
      body: {
        ConstRes.keyWord: keyword,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return FavouriteMusic.fromJson(responseJson);
  }

  Future<UserVideo> getPostsByType({
    required int? pageDataType,
    required String start,
    required String limit,
    String? userId,
    String? soundId,
    String? hashTag,
    String? keyWord,
  }) {
    ///PagedDataType
    ///1 = UserVideo
    ///2 = UserLikesVideo
    ///3 = PostsBySound
    ///4 = PostsByHashTag
    ///5 = PostsBySearch
    switch (pageDataType) {
      case 1:
        return getUserVideos(start, limit, userId, 0);
      case 2:
        return getUserVideos(start, limit, userId, 1);
      case 3:
        return getPostBySoundId(start, limit, soundId);
      case 4:
        return getPostByHashTag(start, limit, hashTag!.replaceAll('#', ''));
      case 5:
        return getSearchPostList(start, limit, userId, keyWord);
    }
    return getPostByHashTag(start, limit, hashTag);
  }

  Future<RestResponse> logoutUser() async {
    SessionManager sessionManager = new SessionManager();
    await sessionManager.initPref();
    // await FireBaseAuth1.FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();
    final response = await client.post(
      Uri.parse(ConstRes.logoutUser),
      body: {
        ConstRes.userId: SessionManager.userId.toString(),
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    sessionManager.clean();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deleteAccount() async {
    SessionManager sessionManager = new SessionManager();
    await sessionManager.initPref();
    await FireBaseAuth1.FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();

    // print(SessionManager.accessToken);
    final response = await client.post(
      Uri.parse(ConstRes.deleteAccount),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    sessionManager.clean();
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> deletePost(String postId) async {
    final response = await client.post(
      Uri.parse(ConstRes.deletePost),
      body: {
        ConstRes.postId: postId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> reportUserOrPost(
    String reportType,
    String? postIdOrUserId,
    String? reason,
    String description,
    String contactInfo,
  ) async {
    final response = await client.post(
      Uri.parse(ConstRes.reportPostOrUser),
      body: {
        ConstRes.reportType: reportType,
        reportType == '1' ? ConstRes.userId : ConstRes.postId: postIdOrUserId,
        ConstRes.reason: reason,
        ConstRes.description: description,
        ConstRes.contactInfo: contactInfo,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> blockUser(String? userId) async {
    final response = await client.post(
      Uri.parse(ConstRes.blockUser),
      body: {
        ConstRes.userId: userId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<SinglePost> getPostByPostId(String postId) async {
    final response = await client.post(
      Uri.parse(ConstRes.getPostListById),
      body: {
        ConstRes.postId: postId,
      },
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return SinglePost.fromJson(responseJson);
  }

  Future<CoinPlans> getCoinPlanList() async {
    final response = await client.get(
      Uri.parse(ConstRes.getCoinPlanList),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return CoinPlans.fromJson(responseJson);
  }

  Future<CoinPlans> addCoin() async {
    final response = await client.post(
      Uri.parse(ConstRes.addCoin),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
      body: {ConstRes.rewardingActionId: '3'},
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    await getProfile(SessionManager.userId.toString());
    return CoinPlans.fromJson(responseJson);
  }

  Future<RestResponse> purchaseCoin(String coin) async {
    // print(SessionManager.accessToken + coin);
    final response = await client.post(
      Uri.parse(ConstRes.purchaseCoin),
      body: {ConstRes.coin: coin},
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );
    // print(response.body);
    final responseJson = jsonDecode(response.body);
    await getProfile(SessionManager.userId.toString());
    return RestResponse.fromJson(responseJson);
  }

  Future<RestResponse> increasePostViewCount(String postId) async {
    final response = await client.post(
      Uri.parse(ConstRes.increasePostViewCount),
      body: {ConstRes.postId: postId},
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
        ConstRes.authorization: SessionManager.accessToken!,
      },
    );

    // print(response.body);
    final responseJson = jsonDecode(response.body);
    return RestResponse.fromJson(responseJson);
  }

  Future<FilePath> filePath({File? filePath}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ConstRes.fileGivenPath),
    );
    request.headers.addAll({
      ConstRes.uniqueKey: ConstRes.apiKey,
      ConstRes.authorization: SessionManager.accessToken!
    });
    if (filePath != null) {
      request.files.add(
        http.MultipartFile(
            'file', filePath.readAsBytes().asStream(), filePath.lengthSync(),
            filename: filePath.path.split("/").last),
      );
    }
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    final responseJson = jsonDecode(respStr);
    FilePath path = FilePath.fromJson(responseJson);
    return path;
  }

  Future pushNotification(
      {required String authorization,
      required String title,
      required String body,
      required String token}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Authorization': 'key=$authorization',
        'content-type': 'application/json'
      },
      body: json.encode(
        {
          'notification': {
            'title': title,
            'body': body,
            "sound": "default",
            "badge": "1"
          },
          'to': '/token/$token',
        },
      ),
    );
  }

  Future<Setting> fetchSettingsData() async {
    final response = await client.post(
      Uri.parse(ConstRes.fetchSettingsData),
      headers: {
        ConstRes.uniqueKey: ConstRes.apiKey,
      },
    );
    // print('data:- ${response.body}');
    SessionManager sessionManager = SessionManager();
    await sessionManager.initPref();
    // print(jsonEncode(User.fromJson(responseJson)));
    sessionManager.saveSetting(response.body);
    return Setting.fromJson(jsonDecode(response.body));
  }

  Future<AgoraToken> generateAgoraToken(String? channelName) async {
    final response =
        await client.post(Uri.parse(ConstRes.generateAgoraToken), headers: {
      ConstRes.authorization: SessionManager.accessToken!,
      ConstRes.uniqueKey: ConstRes.apiKey,
    }, body: {
      ConstRes.channelName: channelName
    });
    print(response.body);
    return AgoraToken.fromJson(jsonDecode(response.body));
  }

  Future<Agora> agoraListStreamingCheck(
      String channelName, String authToken, String agoraAppId) async {
    print(channelName);
    print(authToken);
    http.Response response = await http.get(
        Uri.parse(
            'https://api.agora.io/dev/v1/channel/user/$agoraAppId/$channelName'),
        headers: {'Authorization': 'Basic $authToken'});
    return Agora.fromJson(jsonDecode(response.body));
  }
}

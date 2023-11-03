import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/sound/sound.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/view/dialog/loader_dialog.dart';
import 'package:bubbly/view/music/discover_page.dart';
import 'package:bubbly/view/music/favourite_page.dart';
import 'package:bubbly/view/music/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MainMusicScreen extends StatefulWidget {
  final Function(SoundList?, String) onSelectMusic;

  MainMusicScreen(this.onSelectMusic);

  @override
  _MainMusicScreenState createState() => _MainMusicScreenState();
}

class _MainMusicScreenState extends State<MainMusicScreen> {
  PageController? _controller;
  FocusNode _focus = new FocusNode();
  List<SoundList>? soundList;
  bool isPlay = false;
  SoundList? lastSoundListData;

  AudioPlayer? audioPlayer = AudioPlayer();

  String _localPath = '';
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    _focus.addListener(() {
      Provider.of<MyLoading>(context, listen: false)
          .setIsSearchMusic(_focus.hasFocus);
      soundList = null;
    });
    _controller = PageController(
        initialPage:
            Provider.of<MyLoading>(context, listen: false).getMusicPageIndex,
        keepPage: true);
    // _bindBackgroundIsolate();
    super.initState();
  }

  void _bindBackgroundIsolate() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    print('🙃');
    _port.listen(
      (dynamic data) {
        String id = data[0];
        DownloadTaskStatus status =
            DownloadTaskStatus.undefined; // Initialize with a default value

        // You can directly compare the status to one of the enum values
        if (status == DownloadTaskStatus.complete) {
          widget.onSelectMusic(
              lastSoundListData, _localPath + lastSoundListData!.sound!);
          Navigator.pop(context);
          Navigator.pop(context);
        }
        setState(() {});
      },
    );
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.968,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          SafeArea(
            bottom: false,
            child: Consumer<MyLoading>(
              builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: soundList != null && value.isSearchMusic,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (value.musicSearchText.isEmpty) {
                            FocusScope.of(context).unfocus();
                            MyLoading myLoading =
                                Provider.of<MyLoading>(context, listen: false);
                            myLoading.setIsSearchMusic(false);
                            myLoading.setLastSelectSoundId("");
                            soundList = null;
                            if (audioPlayer != null) {
                              audioPlayer?.release();
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            S.of(context).back,
                          ),
                          width: 45,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: soundList != null ? 0 : 15,
                            top: 15,
                            right: 15),
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 5),
                        height: 45,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            if (audioPlayer != null) {
                              audioPlayer?.release();
                            }
                            MyLoading myLoading =
                                Provider.of<MyLoading>(context, listen: false);
                            myLoading.setMusicSearchText(value);
                            myLoading.setLastSelectSoundId("");
                          },
                          focusNode: _focus,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.of(context).search,
                            hintStyle: TextStyle(
                              color: colorTextLight,
                              fontSize: 15,
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: soundList == null && value.isSearchMusic,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (value.musicSearchText.isEmpty) {
                            FocusScope.of(context).unfocus();
                            if (audioPlayer != null) {
                              audioPlayer?.release();
                            }
                            Provider.of<MyLoading>(context, listen: false)
                                .setIsSearchMusic(false);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            value.musicSearchText.isNotEmpty
                                ? S.of(context).search
                                : S.of(context).cancel,
                          ),
                          width: 60,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 18),
            height: 0,
          ),
          Consumer<MyLoading>(
            builder: (context, value, child) {
              return Visibility(
                visible: !value.isSearchMusic,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          _controller!.animateToPage(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Center(
                          child: Text(
                            S.of(context).discover,
                            style: TextStyle(
                              color: value.getMusicPageIndex == 0
                                  ? Colors.white
                                  : colorTextLight,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          _controller!.animateToPage(1,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        },
                        child: Center(
                          child: Text(
                            S.of(context).favourite,
                            style: TextStyle(
                              color: value.getMusicPageIndex == 1
                                  ? Colors.white
                                  : colorTextLight,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 18),
            height: 0.2,
            color: colorTextLight,
          ),
          Expanded(
            child: Consumer<MyLoading?>(
              builder: (context, value, child) {
                return value != null && !value.isSearchMusic
                    ? PageView(
                        controller: _controller,
                        onPageChanged: (value) {
                          Provider.of<MyLoading>(context, listen: false)
                              .setLastSelectSoundId("");
                          Provider.of<MyLoading>(context, listen: false)
                              .setMusicPageIndex(value);
                          audioPlayer?.release();
                        },
                        children: [
                          DiscoverPage(
                            onMoreClick: (value) {
                              soundList = value;
                              Provider.of<MyLoading>(context, listen: false)
                                  .setIsSearchMusic(true);
                            },
                            onPlayClick: (data) {
                              playMusic(data, 1);
                            },
                          ),
                          FavouritePage(
                            onClick: (data) {
                              playMusic(data, 2);
                            },
                          ),
                        ],
                      )
                    : (soundList != null && soundList!.isNotEmpty
                        ? SearchMusicScreen(
                            soundList: soundList,
                            onSoundClick: (data) {
                              playMusic(data, 3);
                            },
                          )
                        : SearchMusicScreen(
                            onSoundClick: (data) {
                              playMusic(data, 3);
                            },
                          ));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer?.release();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  void playMusic(SoundList data, int type) async {
    MyLoading myLoading = Provider.of<MyLoading>(context, listen: false);
    if (myLoading.isDownloadClick) {
      showDialog(
        context: context,
        builder: (context) => LoaderDialog(),
      );
      myLoading.setIsDownloadClick(false);
      _localPath =
          (await _findLocalPath()) + Platform.pathSeparator + ConstRes.camera;

      final savedDir = Directory(_localPath);

      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      if (File(savedDir.path + data.sound!).existsSync()) {
        File(savedDir.path + data.sound!).deleteSync();
      }
      await FlutterDownloader.enqueue(
        url: "${ConstRes.itemBaseUrl + data.sound!}",
        savedDir: _localPath,
      );
      return;
    }
    if (lastSoundListData == data) {
      if (isPlay) {
        isPlay = false;
        audioPlayer?.pause();
      } else {
        isPlay = true;
        audioPlayer?.resume();
      }
      myLoading.setLastSelectSoundIsPlay(isPlay);
      return;
    }
    lastSoundListData = data;
    myLoading.setLastSelectSoundId(lastSoundListData!.sound! + type.toString());
    myLoading.setLastSelectSoundIsPlay(true);
    if (audioPlayer != null) {
      audioPlayer?.release();
    }
    audioPlayer
        ?.play(UrlSource(ConstRes.itemBaseUrl + "${lastSoundListData?.sound}"));
    isPlay = true;
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    print(directory?.path);
    return "${directory?.path}";
  }
}

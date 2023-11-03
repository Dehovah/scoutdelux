import 'dart:io';

import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/view/upload/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreviewScreen extends StatefulWidget {
  final String? postVideo;
  final String? thumbNail;
  final String? sound;
  final String? soundId;

  PreviewScreen({this.postVideo, this.thumbNail, this.sound, this.soundId});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController? _controller;
  UploadScreen? uploadScreen;

  @override
  void initState() {
    uploadScreen = UploadScreen(
      postVideo: widget.postVideo,
      thumbNail: widget.thumbNail,
      soundId: widget.soundId,
      sound: widget.sound,
    );
    print(widget.postVideo);
    _controller = VideoPlayerController.file(File(widget.postVideo!));
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.setLooping(true);
    _controller?.initialize().then((_) => {setState(() {})});
    _controller?.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
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
                      S.of(context).preview,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.3,
              color: colorTextLight,
              margin: EdgeInsets.only(bottom: 0),
            ),
            Expanded(
              child: Stack(
                children: [
                  AspectRatio(
                      aspectRatio: _controller?.value.aspectRatio ?? 2 / 3,
                      child: VideoPlayer(_controller!)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      onTap: () => showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(child: uploadScreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        backgroundColor: colorPrimaryDark,
                        isScrollControlled: true,
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorTheme,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }
}

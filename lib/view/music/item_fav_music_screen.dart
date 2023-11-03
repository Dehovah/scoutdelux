import 'package:bubbly/modal/sound/sound.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/utils/const.dart';
import 'package:bubbly/utils/my_loading/my_loading.dart';
import 'package:bubbly/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemFavMusicScreen extends StatefulWidget {
  final SoundList soundList;
  final Function onItemClick;
  final int type;

  ItemFavMusicScreen(this.soundList, this.onItemClick, this.type);

  @override
  _ItemFavMusicScreenState createState() => _ItemFavMusicScreenState();
}

class _ItemFavMusicScreenState extends State<ItemFavMusicScreen> {
  final SessionManager sessionManager = new SessionManager();

  @override
  void initState() {
    initSessionManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        widget.onItemClick(widget.soundList);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Consumer<MyLoading>(
              builder: (context, value, child) => Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          ConstRes.itemBaseUrl + widget.soundList.soundImage!),
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Image.asset(icArtist, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: value.lastSelectSoundId ==
                        widget.soundList.sound! + widget.type.toString(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          !value.getLastSelectSoundIsPlay
                              ? Icons.play_arrow_rounded
                              : Icons.pause_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.soundList.soundTitle!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.soundList.singer!,
                    style: TextStyle(
                      color: colorTextLight,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.soundList.duration!,
                    style: TextStyle(
                      color: colorTextLight,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                sessionManager
                    .saveFavouriteMusic(widget.soundList.soundId.toString());
                setState(() {});
              },
              child: Icon(
                sessionManager
                        .getFavouriteMusic()
                        .contains(widget.soundList.soundId.toString())
                    ? Icons.bookmark
                    : Icons.bookmark_border_rounded,
                color: colorTheme,
              ),
            ),
            Consumer<MyLoading>(
              builder: (context, value, child) => Visibility(
                visible: value.lastSelectSoundId ==
                    widget.soundList.sound! + widget.type.toString(),
                child: InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () async {
                    Provider.of<MyLoading>(context, listen: false)
                        .setIsDownloadClick(true);
                    print(widget.soundList.toJson());
                    widget.onItemClick(widget.soundList);
                  },
                  child: Container(
                    width: 50,
                    height: 25,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: colorTheme,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSessionManager() async {
    sessionManager.initPref().then((value) {
      setState(() {});
    });
  }
}

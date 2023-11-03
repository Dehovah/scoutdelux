import 'package:bubbly/generated/l10n.dart';
import 'package:bubbly/modal/sound/sound.dart';
import 'package:bubbly/utils/assert_image.dart';
import 'package:bubbly/utils/colors.dart';
import 'package:bubbly/view/music/item_fav_music_screen.dart';
import 'package:flutter/material.dart';

class ItemDiscoverScreen extends StatelessWidget {
  final SoundData soundData;
  final Function onMoreClick;
  final Function? onPlayClick;

  ItemDiscoverScreen(this.soundData, this.onMoreClick, this.onPlayClick);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  soundData.soundCategoryName ?? '',
                  style: TextStyle(
                      color: colorTheme, overflow: TextOverflow.ellipsis),
                ),
              ),
              InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  onMoreClick.call(soundData.soundList);
                },
                child: Row(
                  children: [
                    Text(
                      S.of(context).more,
                      style: TextStyle(
                        color: colorTextLight,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image(
                      width: 20,
                      image: AssetImage(icMenu),
                      color: colorTheme,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: soundData.soundList?.length,
          itemBuilder: (context, index) {
            return ItemFavMusicScreen(
              soundData.soundList![index],
              (soundUrl) {
                onPlayClick!(soundUrl);
              },
              1,
            );
          },
        )
      ],
    );
  }
}

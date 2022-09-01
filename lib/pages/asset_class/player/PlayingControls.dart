import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:io';
import '../../../utils/constant.dart';
import '../asset_audio_player_icons.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final bool isPlaylist;
  final Function() onPrevious;
  final Function() onPlay;
  final Function() onNext;
  final Function() toggleLoop;
  final Function() onStop;

  PlayingControls({
     this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget _loopIcon(BuildContext context) {
    final iconSize = 34.0;
    if (loopMode == LoopMode.none) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      //single
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 65),
          child: Platform.isIOS? Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: [
              /*GestureDetector(
                onTap: () {
                  if (toggleLoop != null) toggleLoop();
                },
                child: _loopIcon(context),
              ),*/
              /*Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.sim_card_download,color: ColorPalette.appback,size: 20,)
                ),
              ),*/
              SizedBox(width: 29,),
              Container(
                padding: EdgeInsets.all(15),
                child: IconButton(
                    onPressed: isPlaylist ? onPrevious : null,
                    icon: Icon(Icons.skip_previous,color: ColorPalette.appback,size: 30,)
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10,bottom: 30,right: 27),
                child: IconButton(
                  onPressed: onPlay,
                   icon: Icon(
                     isPlaying
                         ? Icons.pause_circle_filled
                         : Icons.play_circle_fill,color: ColorPalette.appback,
                     size: 60,
                   ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(15),
                child: IconButton(
                  onPressed: isPlaylist ? onNext : null,
                  icon: Icon(Icons.skip_next,color: ColorPalette.appback,size: 30,),
                ),
              ),
              /*Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.share,color: ColorPalette.appback,size: 20,)
                ),
              ),*/

             /* if (onStop != null)
                NeumorphicButton(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: EdgeInsets.all(16),
                  onPressed: onStop,
                  child: Icon(
                    AssetAudioPlayerIcons.stop,
                    size: 32,
                  ),
                ),*/
            ],
          ):Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: [
              /*GestureDetector(
                onTap: () {
                  if (toggleLoop != null) toggleLoop();
                },
                child: _loopIcon(context),
              ),*/
              /*Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.sim_card_download,color: ColorPalette.appback,size: 20,)
                ),
              ),*/
              Container(
                padding: EdgeInsets.all(15),
                child: IconButton(
                    onPressed: isPlaylist ? onPrevious : null,
                    icon: Icon(Icons.skip_previous,color: ColorPalette.appback,size: 30,)
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10,bottom: 30,right: 27),
                child: IconButton(
                  onPressed: onPlay,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,color: ColorPalette.appback,
                    size: 60,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.all(15),
                child: IconButton(
                  onPressed: isPlaylist ? onNext : null,
                  icon: Icon(Icons.skip_next,color: ColorPalette.appback,size: 30,),
                ),
              ),
              /*Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.share,color: ColorPalette.appback,size: 20,)
                ),
              ),*/

              /* if (onStop != null)
                NeumorphicButton(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: EdgeInsets.all(16),
                  onPressed: onStop,
                  child: Icon(
                    AssetAudioPlayerIcons.stop,
                    size: 32,
                  ),
                ),*/
            ],
          ),
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //mainAxisSize: MainAxisSize.max,
          children: [
            *//*GestureDetector(
                onTap: () {
                  if (toggleLoop != null) toggleLoop();
                },
                child: _loopIcon(context),
              ),*//*
            Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.sim_card_download,color: ColorPalette.appback,size: 20,)
                ),
              ),

            Container(
                padding: EdgeInsets.all(15),
                child: IconButton(

                    icon: Icon(Icons.share,color: ColorPalette.appback,size: 20,)
                ),
              ),

            *//* if (onStop != null)
                NeumorphicButton(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  padding: EdgeInsets.all(16),
                  onPressed: onStop,
                  child: Icon(
                    AssetAudioPlayerIcons.stop,
                    size: 32,
                  ),
                ),*//*
          ],
        )*/
      ],
    );
  }
}

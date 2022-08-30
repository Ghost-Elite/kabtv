import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabtv/utils/constant.dart';

class AudioFile extends StatefulWidget {
  AudioPlayer advancedPlayer;
   AudioFile({Key key,this.advancedPlayer}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path = 'https://acangroup.org/aar/kabtv/audios/06_Ahna_niyal_bassite_WKSM_Kurel_Ahlou_Badar_pre_Magal_de_TOUBA.mp3';
  bool isPlaying=false;
  bool isPaused=false;
  bool isLoop=false;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
    Icons.skip_next,
    Icons.skip_previous,
    Icons.share,
    Icons.sim_card_download
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {
      _duration=d;
    });});
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {
      _position=p;
    });});
    this.widget.advancedPlayer.setUrl(path);
  }
  Widget btnStart(){
    return IconButton(
      padding: EdgeInsets.only(bottom: 10),
        onPressed: (){
        if(isPlaying==false) {
          this.widget.advancedPlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        }else if(isPlaying==true){
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
        },
      icon:isPlaying==false?Icon(_icons[0],size: 50,color: ColorPalette.appback,):Icon(_icons[1],size: 50,color: ColorPalette.appback,),
    );
  }
  Widget btnFast() {
    return
      IconButton(
        icon: Icon(_icons[2],color: ColorPalette.appback,),
        onPressed: () {
          //this.widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
          this.widget.advancedPlayer.setPlaybackRate(1.5);
        },
      );
  }
  Widget btnSlow() {
    return IconButton(
      icon: Icon(_icons[3],color: ColorPalette.appback,),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
        //this.widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);

      },
    );
  }
  Widget loadAsset(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnStart(),
        ],
      ),
    );
  }
  Widget btnPartage(){
    return IconButton(onPressed: (){}, icon: Icon(_icons[4],color: ColorPalette.appback,));
  }
  Widget btnDoawnload(){
    return IconButton(onPressed: (){}, icon: Icon(_icons[5],color: ColorPalette.appback,));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children:  [
         /* Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split('.')[0],style: TextStyle(fontSize: 16),),
                Text(_duration.toString().split('.')[0],style: TextStyle(fontSize: 16),)
              ],
            ),
          ),*/
          btnDoawnload(),
          btnSlow(),
          loadAsset(),
          btnFast(),
          btnPartage()
        ],
      ),
    );
  }
}

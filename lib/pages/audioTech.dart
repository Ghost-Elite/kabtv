import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kabtv/configs/size_config.dart';

import '../utils/constant.dart';
import 'audoFile.dart';

class AudioTechPage extends StatefulWidget {
  const AudioTechPage({Key key}) : super(key: key);

  @override
  State<AudioTechPage> createState() => _AudioTechPageState();
}

class _AudioTechPageState extends State<AudioTechPage> {
  AudioPlayer advancedPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        title: Text('Audiothèque',style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Container(
        width: SizeConfi.screenWidth,
        height: SizeConfi.screenHeight,
        color: ColorPalette.appback,
        child: Column(
          children: [
            Container(
              width: SizeConfi.screenWidth,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/layer.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
              child: Container(
                child: Text('Assirou Baye Ablaye Niang\n'
                            'Dundal Koor Mosquée Massalikoul Djinane 2022'),
              ),
            ),
            Container(
              width: SizeConfi.screenWidth,
              height: 60,
              decoration: BoxDecoration(
                color: ColorPalette.appSecondary,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(16,),bottomLeft: Radius.circular(16))
              ),
              child: AudioFile(advancedPlayer: advancedPlayer,),
            ),
            Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){

                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 3,left: 10,right: 10),
                              child: Container(
                                width: SizeConfi.screenWidth,
                                height: 85,
                                decoration:  BoxDecoration(
                                  color: ColorPalette.appWhite,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]
                                          .withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0,
                                          3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 60,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/circleRounded.png')
                                            )
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 10, // 1000 list items
                      ),
                    ),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

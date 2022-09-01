import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:io';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../configs/size_config.dart';
import '../../network/audio_api.dart';
import '../../network/requestAudio.dart';
import '../../utils/constant.dart';
import '../liste_audios.dart';
import 'player/PlayingControls.dart';
import 'player/PositionSeekWidget.dart';
import 'player/SongsSelector.dart';
import 'dart:io' as io;

/*void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  runApp(
    NeumorphicTheme(
      theme: NeumorphicThemeData(
        intensity: 0.8,
        lightSource: LightSource.topLeft,
      ),
      child: MyApp(),
    ),
  );
}*/

class AssetAudio extends StatefulWidget {
  var audioss,title;
  AssetAudio({Key key,this.audioss,this.title}) : super(key: key);
  @override
  _AssetAudioState createState() => _AssetAudioState();
}

class _AssetAudioState extends State<AssetAudio> {
  //final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
   AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
   ApiAudio apiAudio;
   ApiAudio apiAlbum;
   bool _isLoading=false;
   String progress;
   double progres=0;
   List mp3=[];
   var titre;
   var text;
   bool loading=false;
   List<RequestAudio> request=[];
   RequestAudio requestAudio;
   ProgressDialog pr;
   ReceivePort _port = ReceivePort();
   var logger =Logger();
   var audios = <Audio>[];
   var urlAudio;
   /*Future<ApiAudio> fetchConnexion() async {

     try {
       var postListUrl =
       Uri.parse(widget.audioss);
       final response = await http.get(postListUrl);
       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         //print(data);
         //logger.w('message',jsonDecode(response.body));
         setState(() {
           apiAudio = ApiAudio.fromJson(jsonDecode(response.body));
           //apiAlbum = apiAudio;
         });

        

          // print('ghost ${apiAlbum.allitems}');
           fetchAudio(apiAudio.allitems[1].feedUrl);
         

       }
     } catch (error, stacktrace) {
       //internetProblem();

       return ApiAudio.withError("Data not found / Connection issue");
     }


   }*/
   /*Future<ApiAudio> fetchAlbum() async {

     try {
       var postListUrl =
       Uri.parse(widget.audioss);
       final response = await http.get(postListUrl);
       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         //print(data);
         //logger.w('message',jsonDecode(response.body));
         setState(() {
           apiAlbum = ApiAudio.fromJson(jsonDecode(response.body));

         });

           //logger.w('message',apiAlbum.allitems[0].feedUrl);



       }
     } catch (error, stacktrace) {
       //internetProblem();

       return ApiAudio.withError("Data not found / Connection issue");
     }


   }*/
   final audioss= <Audio>[
     Audio.network(
       'https://serveur01.ccngroupe.com/01_Ini_AkholouS_Moustapha_diop_Kurel_Ahlou_Badar_pre_Magal_2021.mp3',
       metas: Metas(
         id: 'Online',
         title: 'Online',
         artist: 'Florent Champigny',
         album: 'OnlineAlbum',
         // image: MetasImage.network('https://www.google.com')
         image: MetasImage.network(
             'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
       ),
     ),
   ];

   Future<RequestAudio> fetchAudio() async {
     var sings = <Audio>[];
     try {
       var postListUrl =
       Uri.parse(widget.audioss);
       final response = await http.get(postListUrl);
       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         //print(data);
         /*RequestAudio.fromJson(data);
         logger.w('message',jsonDecode(response.body));
         setState(() {
           mp3 = RequestAudio.fromJson(jsonDecode(response.body));
         });*/

         mp3 = data['allitems'];
         setState(() {
           titre =mp3[0]['title'];
         });

         loading=true;
         logger.w('gh',widget.audioss);
         for(var item in mp3){
           sings.add(
               Audio.network(
               item['stream_url'],
             metas: Metas(
               title: item['title'],
               image: MetasImage.network(
                   item['sdimage']
               ),
               artist: item['desc']
             )
           ));
           //logger.w('bara',item['stream_url']);
         }
        setState((){
          audios=sings;
          //logger.w('ghost 2',audios);
        });
       // logger.w('bara mp3',sings);
         openPlayer(sings);
       }
     } catch (error, stacktrace) {
       //internetProblem();

       return RequestAudio.withError("Data not found / Connection issue");
     }


   }
   Future<void> fetchActualite() async {
     var sings = <Audio>[];
     var postListUrl =
     Uri.parse(widget.audioss);
     final response = await http.get(postListUrl);
     // print(await http.get(postListUrl));
     logger.w('status reponse',response.statusCode);
     if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
       //logger.w(listChannelsbygroup);
       requestAudio = RequestAudio.fromJson(data);

       // logger.i("actu url", apiService?.newsrss[0].title);
       setState(() {
         urlAudio = requestAudio.allitems;

       });

       for(var item in urlAudio){
         logger.w('message',item.streamUrl);
         sings.add(
             Audio.network(
                 item.streamUrl,
                 metas: Metas(
                     title: item.title,
                     image: MetasImage.network(
                         item.sdimage
                     ),
                     artist: item.desc
                 )
             ));
         logger.w('bara',item.streamUrl);
       }
       setState((){
         audios=sings;
         //logger.w('ghost 2',audios);
       });
       logger.w('bara mp3',sings);
       openPlayer(sings);


       // model= AlauneModel.fromJson(jsonDecode(response.body));
     } else {
       throw Exception();
     }
   }
   Future<void> getall() async {
     var sings = <Audio>[];
     var url;
     bool loadRemoteDatatSucceed = false;
     try {
       var response = await http
           .get(Uri.parse('https://acangroup.org/aar/kabtv/laylatoul_qadr2022.json'))
           .timeout(const Duration(seconds: 10), onTimeout: () {

         throw TimeoutException("connection time out try agian");
       });

       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         //logger.w(listChannelsbygroup);
          urlAudio=data['allitems'];
         setState(() {

         });
         //logger.w('message',urlAudio[1]['stream_url']);
         /*for(var item in urlAudio){
           logger.w('message',item['stream_url']);
           sings.add(
               Audio.network(
                   item.streamUrl,
                   metas: Metas(
                       title: item.title,
                       image: MetasImage.network(
                           item.sdimage
                       ),
                       artist: item.desc
                   )
               ));
           logger.w('bara',item.streamUrl);
         }*/
         sings.add(
             Audio.network(
               urlAudio[1]['stream_url'],

             ));
         setState((){
           audios=sings;
           //logger.w('ghost 2',audios);
         });
         logger.w('bara mp3',sings);
         openPlayer(sings);

         loadRemoteDatatSucceed = true;
         logger.i('message',urlAudio);

       } else {

         return null;
       }

     } on TimeoutException catch (_) {
     }

   }

    //Audio.network(
    //  'https://d14nt81hc5bide.cloudfront.net/U7ZRzzHfk8pvmW28sziKKPzK',
    //  metas: Metas(
    //    id: 'Invalid',
    //    title: 'Invalid',
    //    artist: 'Florent Champigny',
    //    album: 'OnlineAlbum',
    //    image: MetasImage.network(
    //        'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
    //  ),
    //),
   /* Audio.network(
      'https://acangroup.org/aar/kabtv/audios/01_Ini_AkholouS_Moustapha_diop_Kurel_Ahlou_Badar_pre_Magal_de_TOUBA.mp3'
    ),*/
   Widget _title(Audio item){
     return Text(item.metas.title);
   }
    myAlbum(){
      return Column(
        children: apiAlbum.allitems.map((items){
          return Column(
            children: [
              Container(
                child: Text(items.title),
              ),
              ListeAudios(url: items.feedUrl,)
            ],
          );
        }).toList(),
      );
    }


  @override
  void initState() {
    super.initState();

    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      logger.w('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      logger.w('audioSessionId : $sessionId');
    }));
    fetchAudio();
    //fetchActualite();
    //getall();


  }

  void openPlayer(audios) async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
    logger.w('bara player ',audios);
  }

  @override
  void dispose() {

    _assetsAudioPlayer.dispose();
    _assetsAudioPlayer=null;

    print('dispose');
    super.dispose();
  }


  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
     final item = audios;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(widget.title,style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: loading ?
        Container(
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
              Container(
                width: SizeConfi.screenWidth,
                height: 150,
                decoration: BoxDecoration(
                    color: ColorPalette.appSecondary,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(16,),bottomLeft: Radius.circular(16))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _assetsAudioPlayer.builderLoopMode(
                          builder: (context, loopMode) {
                            return PlayerBuilder.isPlaying(
                                player: _assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  return PlayingControls(
                                    loopMode: loopMode,
                                    isPlaying: isPlaying,
                                    isPlaylist: true,
                                    onStop: () {
                                      _assetsAudioPlayer.stop();
                                    },
                                    toggleLoop: () {
                                      _assetsAudioPlayer.toggleLoop();
                                    },
                                    onPlay: () {
                                      _assetsAudioPlayer.playOrPause();
                                    },
                                    onNext: () {
                                      //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                      _assetsAudioPlayer.next(
                                          keepLoopMode: true ,/*keepLoopMode: false*/);
                                    },
                                    onPrevious: () {
                                      _assetsAudioPlayer.previous(
                                        /*keepLoopMode: false*/);

                                    },
                                  );
                                });
                          },
                        ),

                      ],
                    ),
                    _assetsAudioPlayer.builderRealtimePlayingInfos(
                        builder: (context, RealtimePlayingInfos infos) {
                          if (infos == null) {
                            return SizedBox();
                          }
                          //print('infos: $infos');
                          return PositionSeekWidget(
                            currentPosition: infos.currentPosition,
                            duration: infos.duration,
                            seekTo: (to) {
                              _assetsAudioPlayer.seek(to);
                            },
                          );
                        }),
                  ],
                ),
              ),
              /*Expanded(
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
                                      padding: const EdgeInsets.all(7.0),
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
                                    Column(
                                      children: [
                                        Container(
                                          child: Text('karamna Kourel Ahlou Badar',),
                                        ),
                                        Container(
                                          child: Text('Dundal Koor Mosquée Massalikoul\n Djinane 2022',style: TextStyle(fontSize: 9),),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(Icons.sim_card_download),
                                              Icon(Icons.sim_card_download),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container()


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
              )*/
              loading? _assetsAudioPlayer.builderCurrent(
                  builder: (BuildContext context, Playing playing) {
                    var logger =Logger();
                    logger.w('message',titre);
                    return SongsSelector(
                      audios: audios,
                      path: mp3,
                      title: text,
                      assetsAudioPlayer: _assetsAudioPlayer,
                      onPlaylistSelected: (myAudios) {
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          showNotification: true,
                          headPhoneStrategy:
                          HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );

                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: NotificationSettings(
                              seekBarEnabled: false,
                              stopEnabled: true,
                              customStopAction: (player){
                               player.stop();
                              }
                             // prevEnabled: false,
                             /* customNextAction: (player) {
                               print('next');
                              }
                              customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                              customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                              customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),*/
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }):Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: Center(child: CircularProgressIndicator(color: ColorPalette.appSecondary,),),
                  ),

            ],
          ),
        ) :
        Center(child: CircularProgressIndicator(color: ColorPalette.appColor,),),
    );

      MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

      Scaffold(
        //backgroundColor: NeumorphicTheme.baseColor(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  /*Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      StreamBuilder<Playing>(
                          stream: _assetsAudioPlayer.current,
                          builder: (context, playing) {
                            if (playing.data != null) {
                              final myAudio = find(
                                  audios, playing.data.audio.assetAudioPath);
                                  print(playing.data.audio.assetAudioPath);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 8,
                                    surfaceIntensity: 1,
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  child: myAudio.metas.image?.path == null
                                      ? const SizedBox()
                                      : myAudio.metas.image?.type ==
                                              ImageType.network
                                          ? Image.network(
                                              myAudio.metas.image.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            )
                                          : Image.asset(
                                              myAudio.metas.image.path,
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.contain,
                                            ),
                                ),
                              );
                            }
                            return SizedBox.shrink();
                          }),
                      Align(
                        alignment: Alignment.topRight,
                        child: NeumorphicButton(
                          style: NeumorphicStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: EdgeInsets.all(18),
                          margin: EdgeInsets.all(18),
                          onPressed: () {
                            AssetsAudioPlayer.playAndForget(
                                Audio('assets/audios/horn.mp3'));
                          },
                          child: Icon(
                            Icons.add_alert,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _assetsAudioPlayer.builderCurrent(
                      builder: (context, Playing playing) {
                    return Column(
                      children: <Widget>[
                        _assetsAudioPlayer.builderLoopMode(
                          builder: (context, loopMode) {
                            return PlayerBuilder.isPlaying(
                                player: _assetsAudioPlayer,
                                builder: (context, isPlaying) {
                                  return PlayingControls(
                                    loopMode: loopMode,
                                    isPlaying: isPlaying,
                                    isPlaylist: true,
                                    onStop: () {
                                      _assetsAudioPlayer.stop();
                                    },
                                    toggleLoop: () {
                                      _assetsAudioPlayer.toggleLoop();
                                    },
                                    onPlay: () {
                                      _assetsAudioPlayer.playOrPause();
                                    },
                                    onNext: () {
                                      //_assetsAudioPlayer.forward(Duration(seconds: 10));
                                      _assetsAudioPlayer.next(
                                          keepLoopMode:
                                              true /*keepLoopMode: false*/);
                                    },
                                    onPrevious: () {
                                      _assetsAudioPlayer.previous(
                                          /*keepLoopMode: false*/);
                                    },
                                  );
                                });
                          },
                        ),
                        /*_assetsAudioPlayer.builderRealtimePlayingInfos(
                            builder: (context, RealtimePlayingInfos infos) {
                          if (infos == null) {
                            return SizedBox();
                          }
                          //print('infos: $infos');
                          return Column(
                            children: [
                              PositionSeekWidget(
                                currentPosition: infos.currentPosition,
                                duration: infos.duration,
                                seekTo: (to) {
                                  _assetsAudioPlayer.seek(to);
                                },
                              ),
                              *//*Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NeumorphicButton(
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: -10));
                                    },
                                    child: Text('-10'),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  NeumorphicButton(
                                    onPressed: () {
                                      _assetsAudioPlayer
                                          .seekBy(Duration(seconds: 10));
                                    },
                                    child: Text('+10'),
                                  ),
                                ],
                              )*//*
                            ],
                          );
                        }),*/
                      ],
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  /*_assetsAudioPlayer.builderCurrent(
                      builder: (BuildContext context, Playing playing) {
                    return SongsSelector(
                      audios: audios,
                      onPlaylistSelected: (myAudios) {
                        _assetsAudioPlayer.open(
                          Playlist(audios: myAudios),
                          showNotification: true,
                          headPhoneStrategy:
                              HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                          audioFocusStrategy: AudioFocusStrategy.request(
                              resumeAfterInterruption: true),
                        );
                      },
                      onSelected: (myAudio) async {
                        try {
                          await _assetsAudioPlayer.open(
                            myAudio,
                            autoStart: true,
                            showNotification: true,
                            playInBackground: PlayInBackground.enabled,
                            audioFocusStrategy: AudioFocusStrategy.request(
                                resumeAfterInterruption: true,
                                resumeOthersPlayersAfterDone: true),
                            headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                            notificationSettings: NotificationSettings(
                                //seekBarEnabled: false,
                                //stopEnabled: true,
                                //customStopAction: (player){
                                //  player.stop();
                                //}
                                //prevEnabled: false,
                                //customNextAction: (player) {
                                //  print('next');
                                //}
                                //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                                //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                                //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
                                ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      playing: playing,
                    );
                  }),*/
                  /*
                  PlayerBuilder.volume(
                      player: _assetsAudioPlayer,
                      builder: (context, volume) {
                        return VolumeSelector(
                          volume: volume,
                          onChange: (v) {
                            _assetsAudioPlayer.setVolume(v);
                          },
                        );
                      }),
                   */
                  /*
                  PlayerBuilder.forwardRewindSpeed(
                      player: _assetsAudioPlayer,
                      builder: (context, speed) {
                        return ForwardRewindSelector(
                          speed: speed,
                          onChange: (v) {
                            _assetsAudioPlayer.forwardOrRewind(v);
                          },
                        );
                      }),
                   */
                  /*
                  PlayerBuilder.playSpeed(
                      player: _assetsAudioPlayer,
                      builder: (context, playSpeed) {
                        return PlaySpeedSelector(
                          playSpeed: playSpeed,
                          onChange: (v) {
                            _assetsAudioPlayer.setPlaySpeed(v);
                          },
                        );
                      }),
                   */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

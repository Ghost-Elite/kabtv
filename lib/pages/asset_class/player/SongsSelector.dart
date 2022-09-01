import 'dart:isolate';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kabtv/utils/constant.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'dart:io';
import 'dart:ui';

import 'package:share_plus/share_plus.dart';
class SongsSelector extends StatefulWidget {
  final Playing playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;
  var path,title;
  AssetsAudioPlayer assetsAudioPlayer;
  SongsSelector(
      { this.playing,
       this.audios,
       this.onSelected,
       this.onPlaylistSelected,this.path,this.title,this.assetsAudioPlayer});

  @override
  State<SongsSelector> createState() => _SongsSelectorState();
}

class _SongsSelectorState extends State<SongsSelector> {
  var logger =Logger();
  Widget _image(Audio item) {
    if (item.metas.image == null) {
      return SizedBox(height: 40, width: 40);
    }

    return item.metas.image?.type == ImageType.network
        ? Image.network(
            item.metas.image.path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )
        : Image.asset(
            item.metas.image.path,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          );
  }

  bool _isLoading=false;

  String progress;

  double progres=0;

  ProgressDialog pr;

  ReceivePort _port = ReceivePort();

  Dio dio;
  String localpath;









  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*dio=Dio();
    _localPath;
    readcontent();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if(status==DownloadTaskStatus.complete){
        print("telechargement complet");
      }
      setState((){ });
    });
    FlutterDownloader.registerCallback(downloadCallback);*/




  }
  @override
  void dispose() {

    print('dispose');
    super.dispose();
  }








  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final item = widget.audios[index];
                      final isPlaying = item.path == widget.playing?.audio.assetAudioPath;
                  return  GestureDetector(
                      onTap: (){
                        //widget.onSelected(item);
                      },

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 350,
                            height: 85,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(
                                  width: 350,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 20,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: isPlaying ? ColorPalette.appColor : Colors.white,
                                  ),
                                  child: Stack(
                                    children:[
                                      Positioned(
                                        left: 13,
                                        top: 9,
                                        child: Container(
                                          width: 67,
                                          height: 67,
                                          child: Stack(
                                            children:[Container(
                                              width: 67,
                                              height: 67,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Color(0xff82bc00), width: 1, ),
                                                color: Colors.white,
                                              ),
                                            ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: 18.42,
                                                    height: 30.15,
                                                   decoration: BoxDecoration(
                                                     image: DecorationImage(
                                                       image: AssetImage('assets/images/mic.png')
                                                     )
                                                   ),
                                                  ),
                                                ),
                                              ),],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 104,
                                        top: 15,
                                        child: Text(
                                          item.metas.title.toString(),
                                          style: TextStyle(
                                            color:  isPlaying ? Color(0xffe7e7e7) : Colors.black,
                                            fontSize: 13,
                                            fontFamily: "Inter",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 104,
                                        top: 33,
                                        child: Text(
                                          item.metas.artist.toString(),
                                          style: TextStyle(
                                            color: Color(0xff424242),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 132,
                                        top: 50,
                                        child: GestureDetector(
                                          onTap: ()=>openShared(),
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            child: IconButton(
                                              onPressed: (){
                                                openShared();
                                              },
                                              icon: Icon(Icons.share,size: 15,color: Color(0xff969792)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 290,
                                        top: 30,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          child: IconButton(
                                            onPressed: (){
                                              widget.onSelected(item);
                                                setState(() {
                                                  widget.title =item.metas.title.toString();
                                                });
                                                logger.w('2022',widget.title =item.metas.title.toString());
                                              },
                                            icon: Icon(isPlaying ? Icons.pause_circle_filled:Icons.play_circle_fill,color: isPlaying ? Colors.white : ColorPalette.appColor,),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 315,
                                        top: 29,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          child: IconButton(
                                            onPressed: (){
                                              //widget.onSelected(item);
                                              logger.w('message tt');
                                              widget.assetsAudioPlayer
                                                  .seekBy(Duration(seconds: 10));
                                            },
                                            icon: Icon(Icons.skip_next,color: isPlaying ? Colors.white : ColorPalette.appColor,),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 106,
                                        top: 50,
                                        child: Container(
                                          width: 12,
                                          height: 15,
                                          child: IconButton(
                                            onPressed: () async{
                                           /*  telecharger(widget.path[index]['stream_url']);*/
                                              logger.w('Ghost-Elite',widget.path[index]['stream_url']);
                                             final status = await Permission.storage.request();

                                             if (status.isGranted) {
                                               final externalDir = await getExternalStorageDirectory();

                                               final id = await FlutterDownloader.enqueue(
                                                 url: widget.path[index]['stream_url'],
                                                 savedDir: externalDir.path,
                                                 fileName: "download",
                                                 showNotification: true,
                                                 openFileFromNotification: true,
                                               );


                                             } else {
                                               print("Permission deined");
                                             }
                                            },
                                            icon: Icon(Icons.sim_card_download,size: 15,color: Color(0xff969792)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  );

                },
                childCount: widget.audios.length,
              ),
            ),
          ],
      ),
    );


      Neumorphic(
      style: NeumorphicStyle(
        depth: -8,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(9)),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 1,
            child: NeumorphicButton(
              onPressed: () {
                widget.onPlaylistSelected(widget.audios);
              },
              child: Center(child: Text('All as playlist')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, position) {
                final item = widget.audios[position];
                final isPlaying = item.path == widget.playing?.audio.assetAudioPath;
                return Neumorphic(
                  margin: EdgeInsets.all(4),
                  style: NeumorphicStyle(
                    depth: isPlaying ? -4 : 0,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: ListTile(
                      leading: Material(
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: _image(item),
                      ),
                      title: Text(item.metas.title.toString(),
                          style: TextStyle(
                            color: isPlaying ? Colors.blue : Colors.black,
                          )),
                      onTap: () {
                        widget.onSelected(item);
                      }),
                );
              },
              itemCount: widget.audios.length,
            ),
          ),
        ],
      ),
    );
  }
  void openShared(){
    if(Platform.isAndroid){
      Share.share(
          "Télécharger l'application KAB TV sur play Store : https://play.google.com/store/apps/details?id=com.acangroup.kabtv");
    }else{
      Share.share("Télécharger l'application KAB TV sur ");
    }
  }
}

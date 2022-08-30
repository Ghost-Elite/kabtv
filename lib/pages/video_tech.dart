import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../configs/size_config.dart';
import '../utils/constant.dart';

class VideoTechPage extends StatefulWidget {
  YoutubeAPI ytApi;
  YoutubeAPI ytApiPlaylist;
  List<YT_API> ytResult = [];
  List<YT_APIPlaylist> ytResultPlaylist = [];
  VideoTechPage(
      {Key key,
      this.ytResult,
      this.ytApi,
      this.ytApiPlaylist,
      this.ytResultPlaylist})
      : super(key: key);

  @override
  State<VideoTechPage> createState() => _VideoTechPageState();
}

class _VideoTechPageState extends State<VideoTechPage> {
  YoutubePlayerController _controller =
      YoutubePlayerController(initialVideoId: '');
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  VoidCallback listeners;
  String lien, title;
  youtubePlayer() {
    lien = widget.ytResult[0].url;
    title = widget.ytResult[0].title;
    _controller = YoutubePlayerController(
      initialVideoId: lien.split("=")[1],
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    youtubePlayer();
  }

  void listener() {
    if (_isPlayerReady && mounted && _controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: ColorPalette.appback,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: ColorPalette.appColor),
          centerTitle: true,
          title: Text('Vidéothèque',
              style: TextStyle(color: ColorPalette.appColor)),
        ),
        body: Column(
          children: [
            Container(
              width: SizeConfi.screenWidth,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/layer.png'),
                      fit: BoxFit.cover)),
            ),
            Container(
              width: SizeConfi.screenWidth,
              height: 190,
              child: _controller != null ? player : Container(),
            ),
            Container(
              width: SizeConfi.screenWidth,
              height: 30,
              decoration: BoxDecoration(
                color: ColorPalette.appSecondary,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: 13,
                      color: ColorPalette.appWhite,
                      fontWeight: FontWeight.w200),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Vidéos similaires',
                    style: GoogleFonts.inter(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward,
                        color: ColorPalette.appColor,
                      ))
                ],
              ),
            ),
            Expanded(
                child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: gidViewVideo(),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget gidViewVideo() {
    return GridView.builder(
      padding: EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          //childAspectRatio: 4 / 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 10),
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            setState(() {
              lien = widget.ytResult[position].url;
              //lien = widget.ytResult[index].url;
            });
            _controller.load(widget.ytResult[position].url.split("=")[1]);
            title = widget.ytResult[position].title;
          },
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.appWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200].withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  //margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              height: 117,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: widget.ytResult[position]
                                  .thumbnail["medium"]["url"],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                "assets/images/cadre.jpeg",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                //color: colorPrimary,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/cadre.jpeg",
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                //color: colorPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                //height: 70,
                                child: Text(
                                  widget.ytResult[position].title,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      color: ColorPalette.appblack,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            width: 30,
                            height: 30,
                            child: IconButton(
                              icon: Icon(
                                Icons.play_circle_fill,
                                color: ColorPalette.appPrimary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        );
      },
      itemCount: widget.ytResult == null ? 0 : widget.ytResult.length,
    );
  }
}

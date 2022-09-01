import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kabtv/pages/home.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_api/youtube_api.dart';
import '../network/api.dart';
import 'asset_class/main.dart';
import 'asset_player.dart';
import 'audioPlayer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final logger = Logger();
  ApiRequest apiRequest;
  bool isLoading = false;
  YoutubeAPI ytApi;
  YoutubeAPI ytApiPlaylist;
  List<YT_API> ytResult = [];
  List<YT_APIPlaylist> ytResultPlaylist = [];
  bool isLoadingPlaylist = true;
  String API_Key = 'AIzaSyDNYc6e906fgd6ZkRY63aMLCSQS0trbsew';
  String API_CHANEL = 'UC83RWsW_qUmlML03tOMTjIw';
  Future<void> callAPI() async {
    //print('UI callled');
    //await Jiffy.locale("fr");
    ytResult = await ytApi.channel(API_CHANEL);
    setState(() {
      //print('UI Updated');
      isLoading = false;
      //callAPIPlaylist();
    });
  }
  Future<void> callAPIPlaylist() async {
    //print('UI callled');
    //await Jiffy.locale("fr");
    ytResultPlaylist = await ytApiPlaylist.playlist(API_CHANEL);
    setState(() {
      print('UI Updated');
      print(ytResultPlaylist[0].title);
      isLoadingPlaylist = false;
    });
  }
  Future<ApiRequest> fetchConnexion() async {

    try {
      var postListUrl =
      Uri.parse("https://serveur01.ccngroupe.com/kabtv/api.json");
      final response = await http.get(postListUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //print(data);
       /* logger.w('message',jsonDecode(response.body));*/
        setState(() {
          apiRequest = ApiRequest.fromJson(jsonDecode(response.body));

        });
        logger.w('message',apiRequest.allitems[0].feedUrl);

      }
    } catch (error, stacktrace) {
      internetProblem();

      return ApiRequest.withError("Data not found / Connection issue");
    }


  }
  Object internetProblem() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Column(
          children: [
            Text('KAB TV',
              textAlign: TextAlign.center,style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
          ],
        ),
        content:  Text(
          "Problème d\'accès à Internet, veuillez vérifier votre connexion et réessayez !!!",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const SplashScreen(

                      )));

                },
                child: Container(
                  width: 120,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child:  Text(
                    "Réessayer",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

  }
  @override
  void initState() {
    // TODO: implement initState
    Wakelock.enable();
    super.initState();
    ytApi = YoutubeAPI(API_Key, maxResults: 50, type: "video");
    //ytApiPlaylist = YoutubeAPI(API_Key, maxResults: 50, type: "playlist");
    callAPI();
    fetchConnexion();
    startTime();
  }
  startTime() async {
    var _duration = const Duration(seconds: 5);

    return Timer(_duration, navigationPage);
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/SplashScreen.png"),
            fit: BoxFit.cover,    // -> 02
          ),
        ),
      ),
    );
  }


  Future<void> navigationPage()async {
    if(apiRequest !=null && apiRequest!=0){
      // logger.i('Ghost-Elite',apiService.allitems[2].feedUrl);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage(
          ytApi: ytApi,
          ytResult: ytResult,
          ytResultPlaylist: ytResultPlaylist,
          audioss: apiRequest.allitems[0].feedUrl,
          photo: apiRequest.allitems[2].feedUrl,
          actu: apiRequest.allitems[1].feedUrl,
          apiRequest: apiRequest,
        ),
        ),
            (Route<dynamic> route) => false,
      );
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RadioPlayerScreen(

        ),
        ),

      );*/
    }else{

    }

  }
}
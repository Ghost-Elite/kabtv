import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabtv/configs/size_config.dart';
import 'package:kabtv/pages/video_tech.dart';
import 'package:kabtv/pages/youtube_lecteur.dart';
import 'package:kabtv/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:io';
import '../network/api.dart';
import 'actu.dart';
import 'actualite.dart';
import 'asset_class/main.dart';
import 'galery_page.dart';
import 'menuAlbum.dart';
import 'audioTech.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  YoutubeAPI ytApi;
  YoutubeAPI ytApiPlaylist;
  List<YT_API> ytResult = [];
  List<YT_APIPlaylist> ytResultPlaylist = [];
  var audioss,photo,actu;
  ApiRequest apiRequest;
   HomePage({Key key,this.apiRequest,this.photo,this.audioss,this.ytResult,this.ytResultPlaylist,this.ytApiPlaylist,this.ytApi,this.actu}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: (){
              scaffold.currentState?.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/menu.png')
                )
              ),
            ),
          ),
        ),
        title: Text('Dalal ak Jam',style: TextStyle(color: ColorPalette.appColor),),
      ),
      body: widget.apiRequest != null ?
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
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 20),
              child: Row(
                children: [
                  Text('Suivez-nous ',style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.bold)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor,))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10,left: 10),
              child: Container(
                width: SizeConfi.screenWidth,
                height: 67,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0,
                            3), // changes position of shadow
                      ),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        opentelegram();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/telegram.png')
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        openwhatsapp();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/whatsap.png')
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoTechPage(
                            ytApi: widget.ytApi,
                            ytResult: widget.ytResult,
                            ytResultPlaylist: widget.ytResultPlaylist,
                          ),
                          ),

                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/youtube.png')
                          )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>openFacebook(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/facebook.png')
                            )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()=>openInstagram(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/instagram.png')
                            )
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => /*AssetAudio(
                    audioss: widget.audioss,

                  )*/ MenuAlbum(
                    audioss: widget.audioss,
                  ),
                  ),

                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20,right: 30,left: 30),
                child: Container(
                  width: SizeConfi.screenWidth,
                  height: 58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0,
                              3), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 30,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/mic.png')
                            )
                          ),
                        ),
                      ),
                      Text('Audiothèque',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoTechPage(
                    ytApi: widget.ytApi,
                    ytResult: widget.ytResult,
                    ytResultPlaylist: widget.ytResultPlaylist,
                  ),
                  ),

                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20,right: 30,left: 30),
                child: Container(
                  width: SizeConfi.screenWidth,
                  height: 58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0,
                              3), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 28,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/videoTech.png')
                              )
                          ),
                        ),
                      ),
                      Text('Vidéothèque',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GaleryPage(
                    photos: widget.photo,
                  ),
                  ),

                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20,right: 30,left: 30),
                child: Container(
                  width: SizeConfi.screenWidth,
                  height: 58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0,
                              3), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 28,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/galerie.png')
                              )
                          ),
                        ),
                      ),
                      Text('Galerie Photos',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor))
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActuPage(
                    actuUrl: widget.actu,
                  ),
                  ),

                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20,right: 30,left: 30),
                child: Container(
                  width: SizeConfi.screenWidth,
                  height: 58,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200]
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0,
                              3), // changes position of shadow
                        ),
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 28,
                          height: 20,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/actu.png')
                              )
                          ),
                        ),
                      ),
                      Text('Actualités - Infos',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 30),
              child: Row(
                children: [
                  Text('Dernières vidéos ',style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.bold),),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor,))
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 160,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10,right: 30,left: 30),
                        itemCount: widget.ytResult.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LecteurYoutubePage(
                                  ytApi: widget.ytApi,
                                  ytResult: widget.ytResult,
                                  ytResultPlaylist: widget.ytResultPlaylist,
                                  url: widget.ytResult[i].url,
                                  titre: widget.ytResult[i].title,
                                ),
                                ),

                              );
                            },
                            child: SizedBox(
                              height: 170,
                              width: 140,
                              //margin: const EdgeInsets.only(left: 6,  top: 10, bottom: 6),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 2,left: 2),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        SizedBox(
                                          height: 130,
                                          width: MediaQuery.of(context).size.width,
                                          child: GestureDetector(
                                            child: ClipRRect(
                                              clipBehavior: Clip.antiAlias,
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: widget.ytResult[i].thumbnail["medium"]["url"],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                      "assets/images/cadre.jpeg",
                                                      width: 100,height: 70,fit: BoxFit.cover,
                                                    ),
                                                errorWidget: (context, url, error) =>
                                                    Image.asset(
                                                      "assets/images/cadre.jpeg",width: 100,height: 70,fit: BoxFit.cover,
                                                    ),
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
                        }),
                  ),
                )
                ],
              ),
            ),

          ],
        ),
      ):
        Center(child: CircularProgressIndicator(color: ColorPalette.appColor,),),
      drawer: DrawerPage(
        actu: widget.actu,
        photo: widget.photo,
        ytApiPlaylist: widget.ytApiPlaylist,
        audioss: widget.audioss,
        ytApi: widget.ytApi,
        ytResult: widget.ytResult,
        ytResultPlaylist: widget.ytResultPlaylist,
      ),
    );
  }

  final Uri _url = Uri.parse('https://www.facebook.com/profile.php?id=100018125285236');
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(''))) {
      throw 'Could not launch $_url';
    }
  }

  openwhatsapp() async{
    var whatsapp ="https://chat.whatsapp.com/Isn1ozElcRgFPtpVxf6doJ";
    var whatsappURl_android = whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }
  opentelegram() async{
    var whatsapp ="https://t.me/KourelAhlouBadar";
    var whatsappURl_android = whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }
  openInstagram() async{
    var whatsapp ="https://instagram.com/kourel_ahlou_badar?utm_medium=copy_link";
    var whatsappURl_android = whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }
  openFacebook() async{
    var whatsapp ="https://www.facebook.com/profile.php?id=100018125285236";
    var whatsappURl_android = whatsapp;
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));

      }


    }

  }

}

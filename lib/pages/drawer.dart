import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabtv/pages/policy.dart';
import 'package:kabtv/pages/video_tech.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:io';
import '../utils/constant.dart';
import 'actu.dart';
import 'apropos.dart';
import 'galery_page.dart';
import 'menuAlbum.dart';

class DrawerPage extends StatefulWidget {
  YoutubeAPI ytApi;
  YoutubeAPI ytApiPlaylist;
  List<YT_API> ytResult = [];
  List<YT_APIPlaylist> ytResultPlaylist = [];
  var audioss,photo,actu;
  DrawerPage({Key key,this.ytResult,this.actu,this.photo,this.ytResultPlaylist,this.ytApiPlaylist,this.ytApi,this.audioss}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(

        child: listDrawer(),
      ),
    );
  }
  Widget listDrawer(){
    return ListView(
      children: [
        DrawerHeader(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/kab.png'),
                    fit: BoxFit.contain
                  )
              ),
            )
        ),
      ListTile(
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
        leading:  GestureDetector(
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
        title: Text('Audiothèque',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
      ),
      Divider(color: ColorPalette.appColor,endIndent: 50,indent: 30),
      ListTile(
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
          leading:  Container(
            width: 30,
            height: 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/videoTech.png')
                )
            ),
          ),
          title: Text('Vidéothèque',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
        ),
      Divider(color: ColorPalette.appColor,endIndent: 50,indent: 30),
      ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GaleryPage(
              photos: widget.photo,
            ),
            ),

          );
        },
        leading:  Container(
          width: 30,
          height: 20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/galerie.png')
              )
          ),
        ),
        title: Text('Galerie Photos',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
      ),
      Divider(color: ColorPalette.appColor,endIndent: 50,indent: 30),
      ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ActuPage(
              actuUrl: widget.actu,
            ),
            ),

          );
        },
        leading:  Container(
          width: 30,
          height: 20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/actu.png')
              )
          ),
        ),
        title: Text('Actualités - Infos',style: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.bold),),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Divider(color: ColorPalette.appColor,endIndent: 10,indent: 10),
      ),
      ListTile(
        onTap: (){
          openShared();
        },
        leading: Container(
          width: 30,
          height: 40,
          child: IconButton(
            icon: const Icon(
              Icons.share,
              size: 20,
              color: ColorPalette.appColor,
            ),
            onPressed: () {
              //openShared();
            },
          ),
        ),
        title:  Text(
          "Partager",
          style: GoogleFonts.inter(
              color: ColorPalette.appblack,
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PolicyPage(

            ),
            ),

          );
        },
          leading: Container(
            width: 30,
            height: 40,
            child: IconButton(
              icon: const Icon(
                Icons.lock,
                size: 20,
                color: ColorPalette.appColor,
              ),
              onPressed: () {
                //openShared();
              },
            ),
          ),
          title:  Text(
            "Politique de confidentialité",
            style: GoogleFonts.inter(
                color: ColorPalette.appblack,
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
          ),
        ),
      ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AproposPage(

            ),
            ),

          );
        },
          leading: Container(
            width: 30,
            height: 40,
            child: IconButton(
              icon: const Icon(
                Icons.info,
                size: 20,
                color: ColorPalette.appColor,
              ),
              onPressed: () {
                //openShared();
              },
            ),
          ),
          title:  Text(
            "A propos",
            style: GoogleFonts.inter(
                color: ColorPalette.appblack,
                fontSize: 14,
                fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

}

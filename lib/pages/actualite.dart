import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:kabtv/network/api_actualite.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';
import '../configs/size_config.dart';
import '../utils/constant.dart';
import 'actuScreen.dart';


class ActualitePage extends StatefulWidget {
  var actuUrl;
  ActualitePage({Key key,this.actuUrl}) : super(key: key);

  @override
  _ActualitePageState createState() => _ActualitePageState();
}

class _ActualitePageState extends State<ActualitePage> with SingleTickerProviderStateMixin{
  ApiActualite apiActualite;
  var logger = Logger();
  var data;
  var actuUrl;
  var indexs =0;
  var test = 0;
  bool isLoading = true;
  int curentindex =0;
  final screens = [

  ];

  Future<void> fetchActualite() async {
    var postListUrl =
    Uri.parse(widget.actuUrl);
    final response = await http.get(postListUrl);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //logger.w(listChannelsbygroup);
      apiActualite = ApiActualite.fromJson(data);

      logger.i("actu url",apiActualite.allitems[0].title);
      setState(() {
        actuUrl =apiActualite.allitems[0].title;
        isLoading=false;
      });
      //getJsonFromXMLUrl(actuUrl);
      //feedWeb(actuUrl);
      // model= AlauneModel.fromJson(jsonDecode(response.body));
      //logger.w('ghost-elite' ,actuUrl);
    } else {
      throw Exception();
    }
  }



  /*Future<void> feedWeb(String url) async {
    final client = IOClient(HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true));

    // RSS feed
    var response = await client.get(
        Uri.parse(url));
    var channel = RssFeed.parse(response.body);
    logger.w(' ghost-elite ', channel.items[0].description);

    // Atom feed
    response =
        await client.get(Uri.parse('https://www.theverge.com/rss/index.xml'));
    var feed = AtomFeed.parse(response.body);
    print(feed);

    client.close();
  }*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchActualite();
      //getUrl();
    /*if (apiItems !=null && apiItems.actu.length !=0) {

    }else{
      logger.i("message1234",actuUrl);
    }*/


    //logger.i(data['channel'],'sdggfghh');   //converter.parse(getUrl());
    //run();
    //logger.i("xml ",getUrl());
    //getJsonFromXMLUrl("https://actunet.net/feed/");


  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Wakelock.enable();
    return data !=null?Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' Xibaar yi ',
            style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        //padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            //cardActu(),
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Wrap(
                    children: [
                     // carousel(),
                     // dernierVideo(),
                      //makeItemEpecial()

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    ):Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' Xibaar yi ',
            style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Center(
        child: CircularProgressIndicator(color: ColorPalette.appColor,),
      ),
    );
  }
  /*Widget cardActu(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 40,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: apiItems.newsrss.length,
          itemBuilder: (context,index){
            return Container(

              alignment: Alignment.center,
              width: SizeConfi.screenWidth /4,

              child: GestureDetector(
                onTap: (){
                  setState(() {
                    apiItems.newsrss[index].feedUrl;
                    test =index;

                  });
                  getJsonFromXMLUrl(apiItems.newsrss[index].feedUrl.toString());
                  logger.i(' Ghost-Elite ',apiItems.newsrss[index].feedUrl.toString());
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: test ==index ?ColorPalette.appColor:Colors.transparent,
                          spreadRadius: 1,
                          //blurRadius: 7,
                          offset: Offset(1, 1),
                        blurStyle: BlurStyle.normal,

                      )
                    ]
                  ),
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    strutStyle: StrutStyle(fontSize: 12.0),
                    text: TextSpan(
                      //style: GoogleFonts.roboto(color: indexs==0 ?Palette.color4:Palette.colorBlack),
                      style: GoogleFonts.roboto(
                          color: test==index ? ColorPalette.appBarColor:ColorPalette.appColorActu,fontWeight: FontWeight.w600
                      ),
                      text:
                      "${apiItems.newsrss[index].title}",),
                  ),
                ),
              ),
            );
          }),
    );
  }
  Widget carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 240.0,
        //aspectRatio: 16/9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,

        scrollDirection: Axis.horizontal,
      ),

      items: [1,2,3,4,5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              //semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shadowColor: Colors.black,
              child: Container(
                width: SizeConfi.screenWidth,
                height: 240,
                color: ColorPalette.appBarColor,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(

                          MaterialPageRoute(
                              builder: (context) => ActuScreenPage(
                                datas: data['channel']['item'][i]['title'],
                                //img: data['channel']['image']['url'],
                                titre: data['channel']['item'][i]['title'],
                                imgDesc: data['channel']['item'][i]['content:encoded'],
                              )
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: SizeConfi.screenWidth,
                        height: 150,
                        child: CachedNetworkImage(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          imageUrl:  data['channel']['image'] !=null?data['channel']['image']['url'].toString():'',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                            "assets/images/cadre.png",
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                            //color: colorPrimary,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/cadre.png",
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                            //color: colorPrimary,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.all(5),
                      width: SizeConfi.screenWidth,
                      child: Text('${*//*data['channel'] >0?*//* data['channel']['item'] != null?data['channel']['item'][i]['title'].toString():''}',
                        style: GoogleFonts.inter(color: ColorPalette.appColorActu,fontWeight: FontWeight.w600,fontSize: 16),overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              )


            ) ;

          },
        );
      }).toList(),
    );
  }
  Widget Actualite(){
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, position) {
        *//*logger.wtf('ghost',data['channel']['item'][position]['title']);*//*
        return Card(
          //semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.black,
          child: Stack(
            children: <Widget>[
              Container(
                width: 250,
                height: 250,
                color: Colors.white,
              ),
              Container(
                child: Column(
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            height: 110,
                            width: MediaQuery.of(context).size.width,
                            imageUrl:  data['channel']['image'] !=null?data['channel']['image']['url'].toString():'',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/cadre.png",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                              //color: colorPrimary,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/cadre.png",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                              //color: colorPrimary,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(

                            MaterialPageRoute(
                                builder: (context) => ActuScreenPage(
                                  datas: data['channel']['item'][position]['title'],
                                  //img: data['channel']['image']['url'],
                                  titre: data['channel']['item'][position]['title'],
                                  imgDesc: data['channel']['item'][position]['content:encoded'],
                                )
                            ),
                          );
                        }
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      width: SizeConfi.screenWidth,
                      height: 70,
                      child: Text('${*//*data['channel'] >0?*//* data['channel']['item'] != null?data['channel']['item'][position]['title'].toString():''}',style: GoogleFonts.inter(color: ColorPalette.appColorActu,fontWeight: FontWeight.w600,fontSize: 16),),
                    )
                  ],
                ),
              ),

            ],
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),

        );
      },
      itemCount: data['channel']!=null?data['channel']['item'].length:0,
    );
  }
  Widget makeItemEpecial() {
    return isLoading?Center(child: CircularProgressIndicator(color: ColorPalette.appColor,),):ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, position) {
        logger.wtf('ghost',data['channel']['item'][position]['title']);
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(

              MaterialPageRoute(
                  builder: (context) => ActuScreenPage(
                    datas: data['channel']['item'][position]['title'],
                    //img: data['channel']['image']['url'],
                    titre: data['channel']['item'][position]['title'],
                    imgDesc: data['channel']['item'][position]['content:encoded'],
                  )
              ),
            );

            var  logger = Logger();
            logger.i("Ghost-Elite : ",data['channel']['item'][position]['description']);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  width: MediaQuery.of(context).size.width,

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 4.0,
                    shadowColor: Colors.grey,
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${*//*data['channel'] >0?*//* data['channel']['item'] != null?data['channel']['item'][position]['title'].toString():''}',
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: ColorPalette.appTextColor),maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            *//*GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                height: 80,
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: *//**//*data['channel'] >0?*//**//*data['channel']['image']['url'],
                                    fit: BoxFit.fitWidth,
                                    width: 140,
                                    height: 80,
                                    placeholder: (context, url) =>
                                        Image.asset(
                                          "assets/images/vignete.jpeg",fit: BoxFit.cover
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          "assets/images/vignete.jpeg",fit: BoxFit.cover
                                        ),
                                  ),
                                ),
                              ),
                            ),*//*
                            Container(
                              width: 130,
                              height: 100,
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  width: 100,
                                  height: 70,
                                  imageUrl: data['channel']['image'] !=null?data['channel']['image']['url'].toString():'',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Image.asset(
                                        "assets/images/cadre.png",
                                        width: 100,height: 70,fit: BoxFit.cover,
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        "assets/images/cadre.png",width: 100,height: 70,fit: BoxFit.cover,
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: *//*data['channel'].length>8?8:data['channel'].length>0?data['channel'].length:0*//*data['channel']!=null?data['channel']['item'].length:0,
    );
  }
  Widget dernierVideo() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            "Dernières infos",
            style: GoogleFonts.inter(
              color: ColorPalette.appTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
                Icons.arrow_forward_ios,
              size: 15,
              color: ColorPalette.appTextColor,
            ),
            onPressed: (){

            },
          ),
        )
      ],

    );
  }*/
}



//data['channel']['image']['url'] data['channel']['item'][i]['title']

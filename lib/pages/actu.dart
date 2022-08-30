import 'dart:async';
import 'dart:convert' show jsonDecode, utf8;

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';
import '../configs/size_config.dart';
import '../network/api_actualite.dart';
import '../network/api_galery.dart';
import '../utils/constant.dart';
import 'actuScreen.dart';
import 'carousoelLoeding.dart';
import 'list_article.dart';

class ActuPage extends StatefulWidget {
  var actuUrl;

  ActuPage({Key key, this.actuUrl}) : super(key: key);

  @override
  _ActuPageState createState() => _ActuPageState();
}

class _ActuPageState extends State<ActuPage>
    with SingleTickerProviderStateMixin {
  // var logger = Logger();
  var news;
  var datas;
  var actuUrl;
  var indexs = 0;
  var test = 0;
  int curentindex = 0;
  final screens = [];
  bool isLoading = true;
  ApiActualite apiActualite;
  var logger =Logger();
  Future<ApiActualite> fetchActualite() async {

    try {
      var postListUrl =
      Uri.parse(widget.actuUrl);
      final response = await http.get(postListUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //print(data);
        //logger.w('message',jsonDecode(response.body));
        setState(() {
          apiActualite = ApiActualite.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
          //apiAlbum = apiAudio;
          datas=apiActualite.allitems;
        });
        logger.w('ghost-elite',apiActualite.allitems[0].title);


      }
    } catch (error, stacktrace) {
      //internetProblem();

      return ApiActualite.withError("Data not found / Connection issue");
    }


  }



  @override
  void initState() {
    super.initState();
    fetchActualite();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return apiActualite !=null?Scaffold(
      backgroundColor: ColorPalette.appback,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' KAB Infos ',
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
                    fit: BoxFit.cover
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*Container(
                    padding: EdgeInsets.all(8),
                    width: SizeConfi.screenWidth,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorPalette.appColor,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Text('Infos',style: TextStyle(color: ColorPalette.appWhite),),
                  ),*/


                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          carousel(),
          Expanded(child: makeItemEpecial())
        ],
      ),
    ):Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' Xibaar Yi ',
            style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Center(
        child: CircularProgressIndicator(color: ColorPalette.appColor,),
      ),
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

      items: [1,2,3,4].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              //semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shadowColor: Colors.black,
                child: Container(
                  width: SizeConfi.screenWidth,
                  height: 240,
                  color: ColorPalette.appWhite,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(

                            MaterialPageRoute(
                                builder: (context) => ActuScreenPage(
                                  img: apiActualite.allitems[i].sdimage,
                                  titre: apiActualite.allitems[i].title,
                                  datas: apiActualite.allitems[i].desc,
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
                            imageUrl: apiActualite.allitems[i].sdimage,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              "assets/images/cadre.jpeg",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                              //color: colorPrimary,
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/cadre.jpeg",
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
                        child: Text(apiActualite.allitems[i].title,
                          style: GoogleFonts.inter(color: ColorPalette.appblack,fontWeight: FontWeight.w600,fontSize: 15),
                          overflow: TextOverflow.ellipsis,
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
  Widget makeItemEpecial() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, position) {

        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(

              MaterialPageRoute(
                  builder: (context) => ActuScreenPage(
                    img: apiActualite.allitems[position].sdimage,
                    titre: apiActualite.allitems[position].title,
                    datas: apiActualite.allitems[position].desc,
                  )
              ),
            );

            var  logger = Logger();
            //logger.i("Ghost-Elite : ",data['channel']['item'][position]['description']);
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
                                child: Text(apiActualite.allitems[position].title,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: ColorPalette.appblack),maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.topLeft,
                               child: Text(apiActualite.allitems[position].type,
                                 style: GoogleFonts.inter(color: ColorPalette.appSecondary,fontWeight: FontWeight.w600),
                               ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            /*GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: 140,
                                height: 80,
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: */
                            /*data['channel'] >0?*/
                            /*data['channel']['image']['url'],
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
                            ),
                            */
                            Container(
                              width: 130,
                              height: 130,
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  width: 100,
                                  height: 70,
                                  imageUrl: apiActualite.allitems[position].sdimage,
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
      itemCount: apiActualite!=null?apiActualite.allitems.length:0,
    );
  }


}
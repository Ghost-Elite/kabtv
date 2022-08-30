import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabtv/network/api_galery.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../configs/size_config.dart';
import '../utils/constant.dart';
import 'galery_images.dart';
import 'galery_shot.dart';

class GaleryPage extends StatefulWidget {
  var photos;
  GaleryPage({Key key,this.photos}) : super(key: key);

  @override
  State<GaleryPage> createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  ApiGalery apiGalery;
  List galery=[];
  var logger =Logger();
  Future<ApiGalery> fetchgalery() async {

     try {
       var postListUrl =
       Uri.parse(widget.photos);
       final response = await http.get(postListUrl);
       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         //print(data);
         //logger.w('message',jsonDecode(response.body));
         setState(() {
           apiGalery = ApiGalery.fromJson(jsonDecode(response.body));
           //apiAlbum = apiAudio;
           galery =apiGalery.allitems;
         });
         logger.w('ghost-elite',galery[0].title);


       }
     } catch (error, stacktrace) {
       //internetProblem();

       return ApiGalery.withError("Data not found / Connection issue");
     }


   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchgalery();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.appback,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text('Galerie photos',style: TextStyle(color: ColorPalette.appColor)),
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
          Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height:  10,),
                  ),
                  SliverToBoxAdapter(
                    child: gidViewVideo(),
                  )
                ],
              )
          )
        ],
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
            logger.w('hello', galery);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GaleryImages(
                photos: apiGalery.allitems[position].sdimage,
                title: apiGalery.allitems[position].title,
                galery: galery,
              ),
              ),

            );
          },
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ColorPalette.appWhite,
                    borderRadius: BorderRadius.circular(16),
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
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              height: 125,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: apiGalery.allitems[position].sdimage,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Image.asset(
                                "assets/images/cadre.jpeg",
                                fit: BoxFit.cover,
                                height: 120,
                                width: 100,
                                //color: colorPrimary,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/cadre.jpeg",
                                fit: BoxFit.cover,
                                height: 120,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Flexible(
                              child: Container(
                                margin: EdgeInsets.all(4),
                                alignment: Alignment.topLeft,
                                //height: 70,
                                child: Text(
                                  apiGalery.allitems[position].title,
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
                            padding: EdgeInsets.only(right: 15,bottom: 15),
                            width: 25,
                            height: 18,
                            child: Icon(
                              Icons.photo,
                              color: ColorPalette.appColor,
                              size: 19,
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
      itemCount: apiGalery == null ? 0 : apiGalery.allitems.length,
    );
  }
}

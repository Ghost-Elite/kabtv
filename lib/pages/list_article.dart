import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kabtv/network/api_actualite.dart';
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import '../configs/size_config.dart';
import '../network/api.dart';



import '../utils/constant.dart';
import 'actu.dart';
import 'actuScreen.dart';

class ListArticle extends StatefulWidget {
  final String url;
  const ListArticle({Key key, @required this.url}) : super(key: key);

  @override
  _ListArticleState createState() => _ListArticleState();
}

class _ListArticleState extends State<ListArticle> {
  ApiActualite apiActualite;
  //ApiService aPIServiceS;
  // var logger = Logger();
  var news = [];
  var data;
  bool isLoading = true;
  var logger =Logger();
  var actuUrl;
  Future<void> fetchActualite() async {
    var postListUrl =
    Uri.parse(widget.url);
    final response = await http.get(postListUrl);
    // print(await http.get(postListUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //logger.w(listChannelsbygroup);


      logger.i("actu url", apiActualite.allitems[0].title);
      setState(() {
        apiActualite = ApiActualite.fromJson(jsonDecode(response.body));
      });

      //getJsonFromXMLUrl(actuUrl);
      // model= AlauneModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getJsonFromXMLUrl(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    /*logger.w(data['channel']['item'][0]['description'].contains("<img")
        ? data['channel']['item'][0]['description']
        .split("src=")[1]
        .split(" ")[0]
        .replaceAll("\"", "")
        .trim()
        : "",'ghost===');*/
    return  Container(
            height: MediaQuery.of(context).size.height,
            //padding: EdgeInsets.only(top: 10),
            // decoration: BoxDecoration(
            //   color: Color.#E5E5E5
            // ),
            decoration: BoxDecoration(
              color: Colors.grey[150],
            ),
            child: Column(
              children: <Widget>[
                // cardActu(),
                Expanded(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Wrap(
                        children: [
                          SizedBox(height: 10,),
                          carousel(),
                          //dernierVideo(),
                          //makeItemEpecial(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }


/*
  item.description.contains("<img")
                              ? item.description
                                  .split("src=")[1]
                                  .split(" ")[0]
                                  .replaceAll("\"", "")
                                  .trim()
                              : "
*/
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
                  color: ColorPalette.appColor,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){

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

                    ],
                  ),
                )


            ) ;

          },
        );
      }).toList(),
    );
  }
  /*Widget listeLaoding() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, position) {
        return Container(
            padding: const EdgeInsets.all(10), child:  card_list_laod());
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      },
      itemCount: data['channel'].length > 8 ? 8 : data['channel'].length,
    );
  }*/



  /*Widget makeItemEpecial() {
    return isLoading?Center(child: CircularProgressIndicator(color: ColorPalette.appColor,),):ListView.builder(
      padding: EdgeInsets.only(top: 10),
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, position) {
        logger.wtf('ghost',data['channel']['item'][position]['description']);
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
                                    imageUrl: *//*
                            *//*data['channel'] >0?*//*
                            *//*data['channel']['image']['url'],
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
                            *//*
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
                                  imageUrl: data['channel']['item'][position]['description'].contains("<img")
                                      ? data['channel']['item'][position]['description']
                                      .split("src=")[1]
                                      .split(" ")[0]
                                      .replaceAll("\"", "")
                                      .trim()
                                      : "",
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
  }*/

  Widget dernierVideo() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Text(
            "Dernières infos ",
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


class listeLaod extends StatelessWidget {
  const listeLaod({Key key, this.height, this.width}) : super(key: key);
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: const Color.fromARGB(255, 3, 0, 0),
        child: Column(children: [
          Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10)))
        ]));
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../configs/size_config.dart';
import '../network/audio_api.dart';
import '../utils/constant.dart';
import 'asset_class/main.dart';

class MenuAlbum extends StatefulWidget {
  var audioss;
  MenuAlbum({Key key,this.audioss}) : super(key: key);

  @override
  State<MenuAlbum> createState() => _MenuAlbumState();
}

class _MenuAlbumState extends State<MenuAlbum> {
  ApiAudio apiAudio;
  List album=[];
  var logger = Logger();
  List<String> date = [
    '2022',
    '2021'
  ];
  var item;
  Future<ApiAudio> fetchConnexion() async {

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
        /*album =data['allitems'];
        logger.w(apiAudio)
        for(item in album){

          logger.w('bara',item['feed_url']);
        }*/
        logger.w(apiAudio.allitems[0].feedUrl);

        // print('ghost ${apiAlbum.allitems}');
        /*fetchAudio(apiAudio.allitems[1].feedUrl);*/


      }
    } catch (error, stacktrace) {
      //internetProblem();

      return ApiAudio.withError("Data not found / Connection issue");
    }


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchConnexion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text('Nos Albums',style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: CustomScrollView(
        slivers: [
          /*SliverToBoxAdapter(
            child: Container(
              *//*margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5)*//* alignment: Alignment.center,
              padding: EdgeInsets.all(15),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                strutStyle: StrutStyle(fontSize: 12.0),
                text: TextSpan(
                  //style: GoogleFonts.roboto(color: indexs==0 ?Palette.color4:Palette.colorBlack),
                  style: GoogleFonts.poppins(
                      color: ColorPalette.appblack,fontWeight: FontWeight.w600,fontSize: 13
                  ),
                  text:
                  " Retrouvez la liste des albums\n "
                   "du Kourel Ahlou Badar - KAB ",),
              ),
            ),
          ),*/
          SliverToBoxAdapter(
            child: Container(
              width: SizeConfi.screenWidth,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/layer.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 5,),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(

                  (BuildContext context, int index) {

                return Container(
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => /*AssetAudio(
                    audioss: widget.audioss,

                  )*/ AssetAudio(
                            audioss: apiAudio.allitems[index].feedUrl,
                            title: apiAudio.allitems[index].title,
                          ),
                          ),

                        );
                      },
                      child:
                      /*Padding(
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
                          *//*Column(
                            children: [
                              Container(
                                child: Text('karamna Kourel Ahlou Badar',),
                              ),
                              Container(
                                child: Text('Dundal Koor Mosquée Massalikoul\n Djinane 2022',style: TextStyle(fontSize: 9),),
                              ),

                            ],
                          ),*//*
                        ],
                      ),
                    ),
                  )*/
                      Column(
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
                                      color: Colors.white,
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
                                                      width: 55,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(apiAudio.allitems[index].sdimage),
                                                            fit: BoxFit.contain
                                                        ),
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
                                            apiAudio.allitems[index].title,
                                            style: TextStyle(
                                              color: Colors.black,
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
                                            apiAudio.allitems[index].desc,
                                            style: TextStyle(
                                              color: Color(0xff424242),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                        /*Positioned(
                                      left: 132,
                                      top: 50,
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        child: IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.share,size: 15,color: Color(0xff969792)),
                                        ),
                                      ),
                                    ),*/
                                        Positioned(
                                          left: 300,
                                          top: 35,
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            /*decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff82bc00), Color(0xff297600)], ),
                                    ),*/
                                            child: IconButton(
                                              onPressed: (){},
                                              icon: Icon(Icons.arrow_forward_ios,color: Color(0xff82bc00),),
                                            ),

                                          ),
                                        ),
                                        /*Positioned(
                                      left: 106,
                                      top: 50,
                                      child: Container(
                                        width: 12,
                                        height: 15,
                                        child: IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.sim_card_download,size: 15,color: Color(0xff969792)),
                                        ),
                                      ),
                                    ),*/
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                          /*Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            strutStyle: StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                              //style: GoogleFonts.roboto(color: indexs==0 ?Palette.color4:Palette.colorBlack),
                              style: GoogleFonts.inter(
                                  color: ColorPalette.appblack,fontWeight: FontWeight.w600
                              ),
                              text: "Album magal",),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      )*/
                        ],
                      )

                  ),
                );
              },
              childCount: apiAudio==null?0:apiAudio.allitems.length, // 1000 list items
            ),
          ),
        ],
      ),
    );
  }
}

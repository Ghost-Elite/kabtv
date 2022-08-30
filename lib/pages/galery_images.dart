import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabtv/configs/size_config.dart';

import '../utils/constant.dart';

class GaleryImages extends StatefulWidget {
  var photos,galery,title,image;
  GaleryImages({Key key,this.galery,this.title,this.photos,this.image}) : super(key: key);

  @override
  State<GaleryImages> createState() => _GaleryImagesState();
}

class _GaleryImagesState extends State<GaleryImages> {
  var imge,titre;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imge = widget.photos;
    titre= widget.title;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' Galerie photos ',
            style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: SizeConfi.screenWidth,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imge),
                  fit: BoxFit.fill
                )
              ),
            ),
          ),
          Container(
            width: SizeConfi.screenWidth,
            height: 35,
            decoration: BoxDecoration(
              color: ColorPalette.appSecondary,
            ),
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5,top: 5),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Serigne ${titre}",
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: ColorPalette.appWhite,
                        fontWeight: FontWeight.w200),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                   width: 30,
                   height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cadre.jpeg')
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5,left: 20),
            child: Row(
              children: [
                Text(' Images similaires  '),
                IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward,color: ColorPalette.appColor,))
              ],
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
          ),
      itemBuilder: (context, position) {
        return GestureDetector(
          onTap: () {
            setState((){
              imge =widget.galery[position].sdimage;
              titre= widget.galery[position].title;
            });
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: widget.galery[position].sdimage,
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


                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: widget.galery == null ? 0 : widget.galery.length,
    );
  }
}

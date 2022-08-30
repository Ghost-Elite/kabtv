import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../configs/size_config.dart';
import '../utils/constant.dart';
import '../utils/dimension.dart';

class GaleryTabImage extends StatefulWidget {
  var photos,galery;
  GaleryTabImage({Key key,this.photos,this.galery}) : super(key: key);

  @override
  State<GaleryTabImage> createState() => _GaleryTabImageState();
}

class _GaleryTabImageState extends State<GaleryTabImage> with SingleTickerProviderStateMixin{
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor=0.8;
  //double _height =Dimensions.pageViewContainer;
  var logger =Logger();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page;
        print('Current value is' +_currPageValue.toString());
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    logger.w('world',widget.galery[0].sdimage);
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
          Container(
            height: 200,
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context,position){
                int index;
                Matrix4 matrix = new Matrix4.identity();
                if (index == _currPageValue.floor()) {
                  var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
                  var currTrans = 20*(1-currScale)/2;
                  matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);
                }else if(index == _currPageValue.floor()+1){
                  var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
                  var currTrans = 20*(1-currScale)/2;
                  matrix = Matrix4.diagonal3Values(1, currScale, 1);
                  matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);
                }else if(index == _currPageValue.floor()+1){
                  var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
                  matrix = Matrix4.diagonal3Values(1, currScale, 1);
                  var currTrans = 20*(1-currScale)/2;
                  matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);

                }else{
                  var currScale= 0.8;
                  matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,90*(1-_scaleFactor)/2,1);
                }
                return Transform(
                  transform: matrix,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          height: 250,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              //color: index.isEven ?Color(0xFF69c5df):Color(0xFF9224cc),
                              image: DecorationImage(
                                  image: NetworkImage(widget.galery[position].sdimage),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              },

            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              
              child: DotsIndicator(
                
                axis: Axis.horizontal,
                dotsCount: 3,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: ColorPalette.appColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _buildPageItem(){
    int index;
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = 20*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);

    }else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = 00*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);
    }else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      var currTrans = 20*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,currTrans,0);

    }else{
      var currScale= 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0,90*(1-_scaleFactor)/2,1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){

            },
            child: Container(
              height: 290,
              margin: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  //color: index.isEven ?Color(0xFF69c5df):Color(0xFF9224cc),
                  image: DecorationImage(
                      image: AssetImage('assets/images/cadre.jpeg'),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }
}

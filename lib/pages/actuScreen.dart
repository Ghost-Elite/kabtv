import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import '../configs/size_config.dart';
import '../utils/constant.dart';



class ActuScreenPage extends StatefulWidget {
  var datas,titre,img,imgDesc;
   ActuScreenPage({Key key,this.datas,this.titre,this.img,this.imgDesc}) : super(key: key);

  @override
  _ActuScreenPageState createState() => _ActuScreenPageState();
}

class _ActuScreenPageState extends State<ActuScreenPage> {
  double _height = 1;
  var logger =Logger();
  @override
  Widget build(BuildContext context) {
    logger.w('message',widget.datas);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text(' Xibaar yi ',
            style: TextStyle(color: ColorPalette.appColor)),
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: SizeConfi.screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 80,),
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
              SizedBox(height: 5,),
              Container(
                width: SizeConfi.screenWidth,
                height: 200,
                decoration:   BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.img),
                        fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                child: Text(widget.titre,style: GoogleFonts.inter(color: ColorPalette.apptext,fontWeight: FontWeight.bold,fontSize: 12),)
              ),
              SizedBox(height: 10,),
              Container(
                width: SizeConfi.screenWidth,
                height: SizeConfi.screenHeight,
                margin: EdgeInsets.all(10),
                child: Text(widget.datas,textAlign: TextAlign.justify,style: TextStyle(fontSize: 13),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//<br>${widget.datas}</br>

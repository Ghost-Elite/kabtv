import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/size_config.dart';
import '../utils/constant.dart';


class AproposPage extends StatefulWidget {
  const AproposPage({Key key}) : super(key: key);

  @override
  State<AproposPage> createState() => _AproposPageState();
}

class _AproposPageState extends State<AproposPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: ColorPalette.appColor),
        centerTitle: true,
        title: Text('A propos',
            style: TextStyle(color: ColorPalette.appColor)),
      ),
      body: Container(
          width: SizeConfi.screenWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/apropos.png'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}

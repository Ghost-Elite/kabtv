import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ColorPalette{
  static const Color appColor = Color(0xff82bc00);
  static const Color appPrimary = Color(0xFF297600);
  static const Color appSecondary = Color(0xFF005400);
  static const Color appSecondColor = Color(0xFF2E2E2D);
  static const Color appback = Color(0xFFF4F4F4);
  static const Color appblack = Color(0xFF000000);
  static const Color apptext = Color(0xFF545454);
  static const Color appWhite= Color(0xFFFFFFFF);
}


class AssetAudioPlayerIcons {
  AssetAudioPlayerIcons._();

  static const _kFontFam = 'AssetAudioPlayer';

  static const IconData play = IconData(0xe800, fontFamily: _kFontFam);
  static const IconData stop = IconData(0xe801, fontFamily: _kFontFam);
  static const IconData pause = IconData(0xe802, fontFamily: _kFontFam);
  static const IconData to_end = IconData(0xe803, fontFamily: _kFontFam);
  static const IconData to_start = IconData(0xe804, fontFamily: _kFontFam);
}
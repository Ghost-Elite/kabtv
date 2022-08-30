import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../configs/size_config.dart';
import '../utils/constant.dart';
class ListeAudios extends StatefulWidget {
  final String url;
  const ListeAudios({Key key,@required this.url}) : super(key: key);

  @override
  State<ListeAudios> createState() => _ListeAudiosState();
}

class _ListeAudiosState extends State<ListeAudios> {
  List mp3 =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImp3();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: mp3.map((item) {
        return GestureDetector(
          onTap: (){
          },
          child: Padding(
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
                  Column(
                    children: [
                      Container(
                        child: Text(item['title']),
                      ),
                      Container(
                        child: Text(item['desc'],style: TextStyle(fontSize: 9),),
                      ),
                      /*Container(
                        child: Row(
                          children: [
                            Icon(Icons.sim_card_download),
                            Icon(Icons.sim_card_download),
                          ],
                        ),
                      )*/
                    ],
                  ),


                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> getImp3() async {
    var postListUrl = Uri.parse(widget.url);
    print('test $postListUrl');
    final response = await http.get(postListUrl);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data);
      //logger.w('message',jsonDecode(response.body));
      setState(() {
        mp3 = data['allitems'];
      });
      print('bara mp3 ${mp3}');
    }
  }

}

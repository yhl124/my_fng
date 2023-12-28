import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../api/fndapi.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int fngIndex = 0;

  @override
  void initState() {
    super.initState();
    //fngIndex = getFngIndex() as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(getFngIndex().toString()),
            ),
            /*
            SizedBox(
              child: CupertinoButton.filled(
                onPressed: setState(() {
                  fngIndex = getFngIndex();
                }),
                child: Text('불러오기'), 
              ),
            )
            */
          ],
        ),
      ),
    );
  }

  Future<int> getFngIndex() async {
    final url = FnbApi().url;
    final response = await http.get(Uri.parse(url), headers: FnbApi().headers());

    if(response.statusCode == 200){
      print('api 응답 : ${response.body}');
    }
    else{
      print('fail : ${response.statusCode}');
    }

    return 1;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/fndapi.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<Map<String,dynamic>> _responsejson;

  int fngIndex = 0;

  @override
  void initState() {
    super.initState();
    _responsejson = getFngIndex();
  }

  @override
  Widget build(BuildContext context) {
    //jsontest();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<Map<String,dynamic>>(
              future: _responsejson,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CupertinoActivityIndicator(radius: 20.0);
                }
                else{
                  final data = snapshot.data!;

                  return Expanded(
                    child:GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10
                      ),
                      itemCount: data['fgi'].length,
                      itemBuilder: (context, index) {
                        final buttontext = data['fgi'].keys.elementAt(index);
                        return CupertinoButton(
                          color: CupertinoColors.activeBlue,
                          onPressed: (){},
                          child: Text(buttontext.toString()), 
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                onPressed: _refreshData,
                child: Text('새로고침'), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      _responsejson = getFngIndex();
    });
  }

  Future<Map<String, dynamic>> getFngIndex() async {
    
    final response = await http.get(Uri.parse(FnbApi().url), headers: FnbApi().headers());

    if(response.statusCode == 200){
      //print('api 응답 : ${response.body}');
      return jsonDecode(response.body);
    }
    else{
      //print('fail : ${response.statusCode}');
      throw Exception('fail : ${response.statusCode}');
    }
    /*
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(FnbApi().sampleresponse);
    */
  }

}
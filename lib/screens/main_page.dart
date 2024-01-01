import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/pallete.dart';
import '../widgets/gauge.dart';
import '../api/fndapi.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<Map<String,dynamic>> _responsejson;

  int fngIndex = 0;
  int _beforeIndex = 0;
  late int _currentIndex;
  late String _currentState;

  @override
  void initState() {
    super.initState();
    //_responsejson = getFngIndex();
    _initData();
  }

  Future<void> _initData() async {
    _responsejson = getFngIndex();

    Map<String, dynamic> response = await _responsejson;
    setState(() {
      _currentState = response['fgi']['now']['valueText'];
      _currentIndex = response['fgi']['now']['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<Map<String,dynamic>>(
              future: _responsejson,//getFngIndex(), 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CupertinoActivityIndicator(radius: 20.0);
                }
                else if (snapshot.hasData){
                  final data = snapshot.data!;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_currentState),
                      Gauge(firstfgi: _beforeIndex, secondfgi: _currentIndex,),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Text(_currentIndex.toString()))
                      ,
                      //Text(data['fgi']['now']['value'].toString()),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            3, (index) => Container(
                              padding: EdgeInsets.all(3.0),
                              width: MediaQuery.of(context).size.width*0.32,
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: Pallete.colorMap[data['fgi'].values.elementAt(index)['valueText']],
                                onPressed: (){
                                  setState(() {
                                    _currentState = data['fgi'].values.elementAt(index)['valueText'];
                                    _beforeIndex = _currentIndex;
                                    _currentIndex = data['fgi'].values.elementAt(index)['value'];
                                  });
                                },
                                child: Text(data['fgi'].keys.elementAt(index).toString(), style: TextStyle(color: Colors.black),), 
                              ),
                            )
                          ),
                        ]
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...List.generate(
                            2, (index) => Container(
                              padding: EdgeInsets.all(3.0),
                              width: MediaQuery.of(context).size.width*0.48,
                              child: CupertinoButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: Pallete.colorMap[data['fgi'].values.elementAt(index+3)['valueText']],
                                onPressed: (){
                                  setState(() {
                                    _currentState = data['fgi'].values.elementAt(index+3)['valueText'];
                                    _beforeIndex = _currentIndex;
                                    _currentIndex = data['fgi'].values.elementAt(index+3)['value'];
                                  });
                                },
                                child: Text(data['fgi'].keys.elementAt(index+3).toString(), style: TextStyle(color: Colors.black),), 
                              ),
                            )
                          ),
                        ]
                      ),
                    ]
                  );
                }
                else{
                  return Text('no data');
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                onPressed: _refreshData,
                child: const Text('새로고침'), 
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    Map<String, dynamic> response = await _responsejson;
    setState(() {
      _responsejson = getFngIndex();
      _beforeIndex = _currentIndex;
      _currentIndex = response['fgi']['now']['value'];
    });
      //getFngIndex();
  }

  Future<Map<String, dynamic>> getFngIndex() async {
    /*
    final response = await http.get(Uri.parse(FnbApi().url), headers: FnbApi().headers());

    if(response.statusCode == 200){
      //print('api 응답 : ${response.body}');
      return jsonDecode(response.body);
    }
    else{
      //print('fail : ${response.statusCode}');
      throw Exception('fail : ${response.statusCode}');
    }
    */
    await Future.delayed(Duration(seconds: 2));
    //print(jsonDecode(FnbApi().sampleresponse)['fgi'].values.elementAt(1)['valueText']);
    return jsonDecode(FnbApi().sampleresponse);
    
  }

}
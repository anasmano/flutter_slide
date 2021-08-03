import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  bool _show = false;
  final _gKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _gKey,
      appBar: AppBar(
        title: Text("Flutter Bottom Sheet"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              displayBottomSheet();
            },
            child: Text("Show Bottom Sheet"),
          )
        ],
      )),
    );
  }

  void displayBottomSheet() {
    _gKey.currentState?.showBottomSheet((context) {
      return Container(
        child: DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 0.7,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              height: 500,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: 65,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}

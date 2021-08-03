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
        body: DraggableScrollableSheet(
          minChildSize: 0.3,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          expand: true,
          builder: (context, scrollController) {
            return Column(
              children: <Widget>[
                // Put all heading in column.
                column(scrollController),
                // Wrap your DaysList in Expanded and provide scrollController to it
                Expanded(child: DaysList(controller: scrollController)),
              ],
            );
          },
        ));
  }

  Widget column(sc) {
    return SingleChildScrollView(
      controller: sc,
      //physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
              height: 5.0,
              width: 70.0,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class DaysList extends StatelessWidget {
  final ScrollController controller;

  const DaysList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller, // assign controller here
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(title: Text("Item $index")),
    );
  }
}

/*
Name: Akshath Jain
Date: 3/18/2019 - 4/26/2021
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2021, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:latlong2/latlong.dart' as latLng;

import 'sliding_panel_ori.dart';

void main() => runApp(SlidingUpPanelExample());

class SlidingUpPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;
  ScrollController _scr = ScrollController();

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: 700,
            minHeight: 300,
            parallaxEnabled: false,
            parallaxOffset: .5,
            body: Container(),
            panelBuilder: (sc) => Column(
              children: <Widget>[
                // Put all heading in column.
                column(sc),
                // Wrap your DaysList in Expanded and provide scrollController to it
                Expanded(child: DaysList(controller: sc)),
              ],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
        ],
      ),
    );
  }

  Widget column(sc) {
    return SingleChildScrollView(
      //physics: BouncingScrollPhysics(),
      //controller: sc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 8.0,
              width: 70.0,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class DaysList extends StatelessWidget {
  final ScrollController controller;
  List<Widget> _widget = List.empty(growable: true);

  DaysList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _widget.add(SizedBox(height: 10));
    List.generate(
        35, (index) => _widget.add(ListTile(title: Text('List $index'))));
    return SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        //reverse: true,
        controller: controller,
        child: Column(
          children: _widget,
        ));
  }
}

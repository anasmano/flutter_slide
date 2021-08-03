/*
Name: Akshath Jain
Date: 3/18/2019 - 4/26/2021
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2021, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

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
  ScrollController scrollController = ScrollController();
  PanelController _pc = PanelController();
  bool _after = false;
  bool _scrDown = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: _pc,
            maxHeight: 600,
            minHeight: 250,
            parallaxEnabled: false,
            parallaxOffset: .5,
            onPanelOpened: () {
              _after = true;
              _scrDown = false;
              print('ONPANELOPENED');
            },
            onPanelClosed: () {
              _after = false;
              print('ONPANELCLOSED');
            },
/*
            header: Column(
              children: [
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 30,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.0,
                ),
              ],
            ),
*/
            body: Scaffold(
              appBar: AppBar(title: Text('Sliding Up')),
              body: Container(
                child: Center(child: Text('CONTAINER')),
              ),
            ),
            //panelBuilder: (sc) => _panel(sc),
            panel: Column(
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
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollStartNotification) {
                        _onStart(scrollNotification.metrics);
                      } else if (scrollNotification
                          is ScrollUpdateNotification) {
                        //_onUpdateScroll(scrollNotification.metrics);
                        _onUpdate(scrollNotification.metrics);
                      } else if (scrollNotification is ScrollEndNotification) {
                        //_onEndScroll(scrollNotification.metrics);
                        _onEnd(scrollNotification.metrics);
                      }
                      return true;
                    },
                    child: ListView.separated(
                      controller: scrollController,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('list item $index'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 0.5,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 21,
                    ),
                  ),
                ),
              ],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
          ),
        ],
      ),
    );
  }

  _onStart(_f) async {
    print('START ${_pc.panelPosition}');
    print(scrollController.position.pixels);
    /*
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      var _c = _pc.panelPosition + 0.2;
      if (_c > 1.0) _c = 1.0;
      await _pc.animatePanelToPosition(_c);
      //panelController.expand();
    }
*/
    if (scrollController.offset <= scrollController.position.minScrollExtent) {
      print('START MIN');
    }

    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      // if (scrollController.position.userScrollDirection ==
      //   ScrollDirection.reverse) {
      //print('scrollController.position.userScrollDirection');
      print('START MIN OUT OF RANGE');
      var _c = _pc.panelPosition - 0.2;
      if (_c < 0.0) _c = 0.0;
      await _pc.animatePanelToPosition(_c,
          duration: Duration(milliseconds: 150));
      _after = true;
      _scrDown = true;
      //await Future.delayed(Duration(seconds: 1));
      //_pc.open();
      //}
      //_pc.open();
      //panelController.anchor();
    }
  }

  _onUpdate(_f) async {
    print("UPDATE");
    _scrDown = false;
    //if (_pc.panelPosition != 1.0) {
    if (_after == true) {
      _pc.open();
      print('AFTER');
    } else if (!_pc.isPanelOpen) {
      print('OPEN WHEN SCROLLING');
      _pc.open();
    }
    //}
    /*
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      var _c = _pc.panelPosition + 0.2;
      if (_c > 1.0) _c = 1.0;
      await _pc.animatePanelToPosition(_c);
      //panelController.expand();
    }

    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      var _c = _pc.panelPosition - 0.1;
      if (_c < 0.0) _c = 0.0;
      await _pc.animatePanelToPosition(_c);
      //panelController.anchor();
    }
    */
  }

  _onEnd(ScrollMetrics _f) async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      //var _c = _pc.panelPosition + 0.2;
      //if (_c > 1.0) _c = 1.0;
      //await _pc.animatePanelToPosition(_c);
      print("UP");
      if (!_pc.isPanelOpen) {
        _pc.open();
      }
      //panelController.expand();
    } else if (scrollController.offset <=
            scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print("BOTTOM");
      var _c = _pc.panelPosition;
      // -0.2;
      if (_c < 0.0) _c = 0.0;

      print('END CCC ${_pc.panelPosition}');

      await _pc.animatePanelToPosition(_c);

      print('END CCC ${_pc.panelPosition}');
      if (_scrDown == true) {
        await _pc.close();
      }
    } else if (_f.axisDirection == AxisDirection.up) {
      print("SCROLLLL");
      if (!_pc.isPanelOpen) await _pc.open();
    }
  }
}

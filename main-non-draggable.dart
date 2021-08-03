import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';

import 'sliding_panel.dart';

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
  ScrollController _scr = ScrollController();
  PanelController _dc = PanelController();
  bool _en = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          LayoutBuilder(
            builder: (context, c) => SlidingUpPanel(
              onPanelOpened: () async => await _dc.scrollingEnabledTrue(),
              onPanelClosed: () async => await _dc.scrollingEnabledFalse(),
              controller: _dc,
              //maxHeight: MediaQuery.of(context).size.height - 40,
              maxHeight: c.maxHeight * 0.94,
              minHeight: 230,
              //parallaxEnabled: true,
              parallaxOffset: .5,
              body: Scaffold(
                appBar: AppBar(
                  title: Text('FLUTTER SLIDING UP'),
                ),
                body: Center(
                  child: Container(
                    child: Text('HI, FLUTTER'),
                  ),
                ),
              ),
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
              // onPanelSlide: (double pos) => setState(() {
              //   _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
              //       _initFabHeight;
              // }),
            ),
          ),
        ],
      ),
    );
  }

  Widget column(sc) {
    return GestureDetector(
      //onVerticalDragEnd: ,
      //onVerticalDragDown: ,
      onVerticalDragDown: (c) async {
        //print('object');
        await _dc.scrollingEnabledDown();
        // if (_dc.getScrollingEnabled == true) {
        //   _dc.setScrollingEnabled = false;
        //   _en = true;
        // }
      },
      onVerticalDragEnd: (c) async {
        //print('ok');
        await _dc.scrollingEnabledUp();
        // if (_en = true) {
        //   _dc.setScrollingEnabled = true;
        //   _en = false;
        // }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: 65,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            SizedBox(height: 13),
          ],
        ),
      ),
    );
  }

  Widget columnc(sc) {
    return Listener(
      onPointerDown: (PointerDownEvent p) => _dc.onPointerDown(p),
      //_vt.addPosition(p.timeStamp, p.position),
      //print('object'),
      onPointerMove: (PointerMoveEvent p) {
        _dc.onPointerMove(p);
        //_vt.addPosition(p.timeStamp,            p.position); // add current position for velocity tracking
        //_onGestureSlide(p.delta.dy);
        //print('object');
      },
      onPointerUp: (PointerUpEvent p) => _dc.onPointerUp(p),
      //_onGestureEnd(_vt.getVelocity()),

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

  Widget column1(sc) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails dets) => //print('object'),
          _dc.onGestureSlide(dets.delta.dy),
      onVerticalDragEnd: (DragEndDetails dets) => //print('OKKKK'),
          _dc.onGestureEnd(dets.velocity),
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

class DaysList extends StatefulWidget {
  final ScrollController controller;

  DaysList({Key? key, required this.controller}) : super(key: key);

  @override
  _DaysListState createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  List<Widget> _widget = List.empty(growable: true);

  @override
  void initState() {
    _widget.add(SizedBox(height: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List.generate(
        35, (index) => _widget.add(ListTile(title: Text('List $index'))));
    return SingleChildScrollView(
        //physics: BouncingScrollPhysics(),
        //reverse: true,
        controller: widget.controller,
        child: Column(
          children: _widget,
        ));
  }
}

class DaysList1 extends StatelessWidget {
  final ScrollController controller;

  const DaysList1({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: controller, // assign controller here
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(title: Text("Item $index")),
    );
  }
}

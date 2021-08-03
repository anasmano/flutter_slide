/// Flutter code sample for ScaffoldState.showBottomSheet

// This example demonstrates how to use `showBottomSheet` to display a
// bottom sheet when a user taps a button. It also demonstrates how to
// close a bottom sheet using the Navigator.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("App Bar without Back Button"),
        //   automaticallyImplyLeading: false,
        // ),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showBottomSheet'),
        onPressed: () {
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return DraggableScrollableSheet(
                minChildSize: 0.3,
                initialChildSize: 0.3,
                maxChildSize: 0.94,
                expand: false,
                builder: (context, scrollController) {
                  return Column(
                    children: <Widget>[
                      // Put all heading in column.
                      column(scrollController),
                      // Wrap your DaysList in Expanded and provide scrollController to it
                      Expanded(child: _list(scrollController)),
                      //Expanded(child: DaysList(controller: scrollController)),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
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

  Widget _list(sc) {
    return ListView.builder(
      controller: sc, // assign controller here
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(title: Text("Item $index")),
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

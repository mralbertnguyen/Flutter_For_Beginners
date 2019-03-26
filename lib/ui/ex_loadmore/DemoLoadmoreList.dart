import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/customLib/loadmore/LoadMoreCus.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewModel{
  int id;
  String title;

  ViewModel(int _id, String _title){
    this.id = _id;
    this.title = _title;
  }
}

class DataModel{
  int count;
  List<ViewModel> result;

  DataModel(int _count, List<ViewModel> _result){
    this.count = _count;
    this.result = _result;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  int get count => items.length;

  List<ViewModel> items = [];
  List<ViewModel> api_result = [
    ViewModel(1, "Hello"),
    ViewModel(1, "Hello"),
    ViewModel(1, "Hello"),
    ViewModel(1, "Hello"),
    ViewModel(1, "Hello"),
  ];

  void initState() {
    super.initState();
    // list.addAll(List.generate(30, (v) => v));
  }

  void load() {
    setState(() {
      items.addAll(api_result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: RefreshIndicator(
          child: LoadMoreCus(
            isFinish: count >= 60,
            onLoadMore: _loadMore,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(
                      items[index].id.toString(),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  height: 40.0,
                  alignment: Alignment.center,
                );
              },
              itemCount: count,
            ),
            delegate: DefaultLoadMoreDelegate(),
          ),
          onRefresh: _refresh,
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    items.clear();
    load();
  }
}
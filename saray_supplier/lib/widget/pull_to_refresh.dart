import 'dart:async';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PullToRefresh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState();
  }
}

class _SwipeToRefreshState extends State<PullToRefresh> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  final _words = <WordPair>[];

  @override
  void initState() {
    super.initState(); //initializing list
    _words.addAll(generateWordPairs().take(20));
  }

  @override
  Widget build(BuildContext context) {

//It'll create a item of list.

    Widget _buildRow(WordPair pair) {
      return new Column(
        children: <Widget>[
          new ListTile(
            title: new Text(
              pair.asPascalCase,
            ),
          ),
          new Divider(),
        ],
      );
    }

    Widget _buildSuggestions() {
      return new ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _words.length,
          itemBuilder: (context, i) {
            return _buildRow(_words[i]);
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pull To Refresh",
          style: new TextStyle(color: Colors.white),
        ),
      ),    //wraping listview inside of RefreshIndicator
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: _buildSuggestions()),
    );
  }
  //Trigger method after pull to down.
  Future<Null> _refresh() async {
    //Holding pull to refresh loader widget for 2 sec.
    //You can fetch data from server.
    await new Future.delayed(const Duration(seconds: 2));
    _words.clear();
    setState(() => _words.addAll(generateWordPairs().take(20)));
    return null;
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/provider/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    getHistory();
    super.initState();
  }

  void getHistory() async {
    List _tempHist = [];
    await FirebaseFirestore.instance.collection("history").get().then((value) {
      if (value.docs.length > 0) {
        context.read<History>().history.clear();
        _tempHist.clear();
        value.docs.forEach((element) {
          HistoryModel newHistory = HistoryModel(
            expression: element.data()['expression'],
            result: element.data()['result']
          );
          _tempHist.add(newHistory);
        });
        context.read<History>().updatelist(_tempHist);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade800,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.blueGrey.shade800,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Container()),
                      TabBar(tabs: [
                        Tab(
                          child: Text(
                            "History",
                            style: TextStyle(
                              fontFamily: "BarlowBold",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Memory",
                            style: TextStyle(
                              fontFamily: "BarlowBold",
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[buildHistoryView(), buildHistoryView()],
          ),
        ),
      ),
    );
  }

  Widget buildHistoryView() {
    return ListView.builder(
        itemCount: context.watch<History>().history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              context.watch<History>().history[index].expression, style: TextStyle(fontSize: 20, color: Colors.grey, letterSpacing: 2.0) , textAlign: TextAlign.right,  
            ),
            subtitle: Text(context.watch<History>().history[index].result, style: TextStyle(fontSize: 30, color: Colors.white) , textAlign: TextAlign.right,),
            trailing: Container(
              child: Text('=', style: TextStyle(fontSize: 20, color: Colors.grey) , textAlign: TextAlign.right,),
            )
          );
        });
  }
}

class HistoryModel {
  final String expression;
  final String result;

  HistoryModel({required this.expression, 
  required this.result
  });
}
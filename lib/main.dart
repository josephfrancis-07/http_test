import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Fetch Test"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: RaisedButton(
            child: Text("Fetch Data"),
            color: Colors.blueAccent,
            onPressed: () {
              print("Button Pressed");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Welcome();
              }));
            }),
      ),
    );
  }
}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  String stringresponse;
  Map mapResponse;

  Future fetchData() async {
    http.Response res;
    res = await http.get('https://jsonplaceholder.typicode.com/todos/1');
    if (res.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(res.body);
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Fetch Test"),
        backgroundColor: Colors.blueAccent,
      ),
      body: mapResponse == null
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("Trying to Fetch Data..."),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
                color: Colors.transparent,
              ),
            ])
          : Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  children: [
                    Text("UserID : "),
                    Text(mapResponse["userId"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("ID : "),
                    Text(mapResponse["id"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Title : "),
                    Text(mapResponse["title"].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text("Completed : "),
                    Text(mapResponse["completed"].toString()),
                  ],
                ),
              ])),
    );
  }
}

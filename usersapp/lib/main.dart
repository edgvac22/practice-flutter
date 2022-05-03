import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


void main() {
  runApp(
    // ignore: prefer_const_constructors
    MaterialApp(
      home: const HomePage()
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  Map data = {};
  List usersData = [];

  getUsers() async {
    String url = 'http://10.0.2.2:4000/api/users';
    http.Response response = await http.get(Uri.parse(url));
    data = json.decode(response.body);
    setState(() {
      usersData = data['users'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.indigo[900],
        ),
        body: ListView.builder(
          // ignore: unnecessary_null_comparison
          itemCount: usersData == null ? 0 : usersData.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "$index",
                       style: const TextStyle(
                         fontSize: 20.0, 
                         fontWeight: FontWeight.w500
                         ),
                         ),
                    ),
                    CircleAvatar(backgroundImage: NetworkImage(usersData[index]['avatar']),),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("${usersData[index]["firstName"]} ${usersData[index]["lastName"]}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
              ),
              ),
            );
          },
        ),
      );
  }
}
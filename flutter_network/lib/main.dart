import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Network Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Comment> fetchComment() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments/1'));
    if (response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Network'),
      ),
      body: Center(
        child: FutureBuilder<Comment>(
          future: fetchComment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.body);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Text("Loading");
          },
        ),
      ),
    );
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

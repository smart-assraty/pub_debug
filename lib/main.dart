import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PUB poluchaetsya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PUB poluchaetsya page 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String string = "default";
  String password = "";
  List<String> input = [];
  List<String> output = [];
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("P.UB library")),
        body: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    var result = await Process.run(
                        './n.sh', [myController.text],
                        runInShell: true);
                    setState(() => string = result.stdout);
                  },
                  child: const Text('Show neighbors'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var result = await Process.run(
                        './o.sh', [myController.text],
                        runInShell: true);
                    setState(() => string = result.stdout);
                  },
                  child: const Text('Show originators'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Enter MAC-address:"),
                            content: TextField(onSubmitted: (value) async {
                              input.add(value);
                              var result = await Process.run(
                                  './tp.sh', [myController.text, "$input"],
                                  runInShell: true);
                              input.clear();
                              setState(() => string = result.stdout);
                            }),
                          );
                        });
                  },
                  child: const Text('Throughput meter'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var result = await Process.run(
                        './tcpdump.sh', [myController.text],
                        runInShell: true);
                    setState(() => string = result.stdout);
                  },
                  child: const Text('TCP dump'),
                ),
              ],
            ),
            Center(
              child: Text(
                string,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    backgroundColor: Colors.black),
              ),
            ),
          ],
        ));
  }
}

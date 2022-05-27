import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: Text('example'),
          )
        ],
        body: Row(
          children: [
            SizedBox(
              width: 500,
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) => ListTile(
                  title: Text('tile $index'),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 500, color: Colors.yellow),
                    Container(height: 500, color: Colors.orange),
                    Container(height: 500, color: Colors.blue),
                    Container(height: 500, color: Colors.yellow),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

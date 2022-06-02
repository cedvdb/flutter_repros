import 'package:flutter/material.dart';
import 'package:flutter_repros/sync_duo_scroll_controllers.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SyncDuoScrollControllers controllers = SyncDuoScrollControllers()..link();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar.medium(
            title: const Text('example'),
          )
        ],
        body: SingleChildScrollView(
          child: Row(
            children: [
              SizedBox(
                width: 500,
                child: CustomScrollView(
                  slivers: [
                    SliverFixedExtentList(
                      itemExtent: 60,
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => ListTile(
                                title: Text('tile $index'),
                              ),
                          childCount: 10),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('secon list'),
                      ),
                    ),
                    SliverFixedExtentList(
                      itemExtent: 60,
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(
                          title: Text('tile $index'),
                        ),
                        childCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(height: 500, color: Colors.yellow),
                    Container(height: 500, color: Colors.orange),
                    Container(height: 500, color: Colors.blue),
                    Container(height: 500, color: Colors.yellow),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

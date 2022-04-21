import 'package:flutter/material.dart';
import 'package:flutter_repros/overlay_button.dart';
import 'package:flutter_repros/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingleChildScrollView(
        child: SizedBox(
          height: 1500,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightTheme,
                        home: const MyHomePage(title: 'light'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkTheme,
                        home: const MyHomePage(title: 'dark'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightThemeM3,
                        home: const MyHomePage(title: 'light m3'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkThemeM3,
                        home: const MyHomePage(title: 'dark m3'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightThemeFromSwatch,
                        home: const MyHomePage(title: 'light from swatch'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkThemeFromSwatch,
                        home: const MyHomePage(title: 'dark from swatch'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightThemeFromSwatchM3,
                        home: const MyHomePage(title: 'light from swatch m3'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkThemeFromSwatchM3,
                        home: const MyHomePage(title: 'dark from swatch m3'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightThemeSeeded,
                        home: const MyHomePage(title: 'light seeded'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkThemeSeeded,
                        home: const MyHomePage(title: 'dark seeded'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.lightThemeSeededM3,
                        home: const MyHomePage(title: 'light seeded m3'),
                      ),
                    ),
                    Expanded(
                      child: MaterialApp(
                        theme: Themes.darkThemeSeededM3,
                        home: const MyHomePage(title: 'dark seeded m3'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: SizedBox(
                  height: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('elevated'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('outlined'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: OverlayButton(
                onTap: () {}, child: const Text('elevated material')),
          ),
        ],
      ),
    );
  }
}

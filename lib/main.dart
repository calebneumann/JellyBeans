import 'package:app_project/init.dart';
import 'package:app_project/models/Assignment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/SettingsPage.dart';
import 'pages/CalendarPage.dart';
import 'pages/ListPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        home: FutureBuilder(
          future: _initFuture,
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return MyHomePage();
            } else {
              return MyHomePage(); // TODO: make a loading screen
            }
          }),
        ),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  Assignments assignments = Assignments();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  final List _screens = [
    {
      "screen": const ListPage(),
      "title": "\n"
    }, //app crashes if the "title" object is absent
    {"screen": CalendarPage(), "title": "\n"},
    {"screen": SettingsPage(), "title": "\n"},
  ];

  void _selectScreen(int value) {
    setState(() {
      //changes the page to the selected one
      selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "We might add something here?\nI think it's just on the list page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: _screens[selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
      ),
    );
  }
}

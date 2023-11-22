import 'package:app_project/init.dart';
import 'package:app_project/models/Assignment.dart';
import 'package:app_project/models/Themes.dart';
import 'package:app_project/pages/AssignmentPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/SettingsPage.dart';
import 'pages/CalendarPage.dart';
import 'pages/ListPage.dart';
import 'pages/CanvasPage.dart';
import 'pages/ViewPage.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

Color theme = Colors
    .pink; //turned theme into variable so that it can eventually be changed on command
Color navBarTheme = Colors.white;

void main() => runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(lightTheme),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future _initFuture = Init.initialize();
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: themeNotifier.getTheme(),
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
  Assignment? currentAssignment;

  // Assignment? get currentAssignment => _currentAssignment;

  // set currentAssignment(Assignment? assignment) {
  //   _currentAssignment = assignment;
  //   notifyListeners();
  // }

  MyAppState() {
    // TODO: This is for testing assignment pulling. This code will not be in the final version
    Assignment as1 = assignments.createAssignment();
    as1.name = "Sample Assignment 1";
    as1.dueDate = DateTime.parse('2023-01-03 14:30:00Z');
    Assignment as2 = assignments.createAssignment();
    as2.name = "Sample Assignment 2";
    as2.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    Assignment as3 = assignments.createAssignment();
    as3.name = "Sample Assignment 3";
    as3.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    Assignment as4 = assignments.createAssignment();
    as4.name = "Sample Assignment 4";
    as4.dueDate = DateTime.parse('2024-10-21 16:00:00Z');
    //*/
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  void _selectScreen(dynamic value) {
    setState(() {
      //changes the page to the selected one
      //TODO: move to appState
      if (value is int) {
        selectedIndex = value;
      } else if (value is Assignment) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ViewPage(assignment: value, selectScreen: _selectScreen),
          ),
        );
      }
    });
  }

  late final List _screens = [
    {
      "screen": ListPage(selectScreen: _selectScreen),
      "title": "\n"
    }, //app crashes if the "title" object is absent
    {"screen": CalendarPage(selectScreen: _selectScreen), "title": "\n"},
    {"screen": AssignmentPage(selectScreen: _selectScreen), "title": "\n"},
    {"screen": CanvasPage(), "title": "\n"},
    {"screen": SettingsPage(), "title": "\n"},
  ];

  //Working on getting a splash screen set up
  // @override
  // void initState(){
  //   super.initState();
  //   initialization();
  // }

  // void initialization() async{
  //   print('ready in 3...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 2...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('ready in 1...');
  //   await Future.delayed(const Duration(seconds: 1));
  //   print('go!');
  //   FlutterNativeSplash.remove();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Jelly Beans' Homework Tracker v0.2",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: theme,
      ),
      body: _screens[selectedIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
        selectedItemColor: Color.fromARGB(255, 119, 117,
            117), //had issue where nav rail was invisible, added these to fix
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}


//idk why but it wouldn't work if it was in a different file
class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

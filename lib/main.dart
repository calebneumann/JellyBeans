import 'package:app_project/init.dart';
import 'package:app_project/models/Assignment.dart';
import 'package:app_project/pages/AssignmentPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/SettingsPage.dart';
import 'pages/CalendarPage.dart';
import 'pages/ListPage.dart';
import 'pages/CanvasPage.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  //async  ^ for when we get splash screen working
  //stuff for splash screen
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future _initFuture = Init.initialize();
  static Color theme = Colors
      .pink; //turned theme into variable so that it can eventually be changed on command
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: theme),
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

  MyAppState() {
    // TODO: This is for testing assignment pulling. This code will not be in the final version
    Assignment as1 = assignments.createAssignment();
    as1.name = "assignment1";
    as1.dueDate = DateTime.parse('2023-01-03 14:30:00Z');
    Assignment as2 = assignments.createAssignment();
    as2.name = "assignment2";
    as2.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    Assignment as3 = assignments.createAssignment();
    as3.name = "assignment3";
    as3.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    Assignment as4 = assignments.createAssignment();
    as4.name = "assignment4";
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

  final List _screens = [
    {
      "screen": const ListPage(),
      "title": "\n"
    }, //app crashes if the "title" object is absent
    {"screen": CalendarPage(), "title": "\n"},
    {"screen": AssignmentPage(), "title": "\n"},
    {"screen": CanvasPage(), "title": "\n"},
    {"screen": SettingsPage(), "title": "\n"},
  ];

  void _selectScreen(int value) {
    setState(() {
      //changes the page to the selected one
      selectedIndex = value;
    });
  }

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
          "Jelly Beans' Homework Tracker v0.1",
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
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: "Account"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
        fixedColor: const Color.fromARGB(255, 65, 65,
            65), //had issue where nav rail was invisible, added these to fix
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

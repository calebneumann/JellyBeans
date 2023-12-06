import 'package:app_project/init.dart';
import 'package:app_project/models/Assignment.dart';
import 'package:app_project/models/Themes.dart';
import 'package:app_project/pages/AssignmentPage.dart';
import 'package:app_project/pages/SettingsPageWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void main() {
  //locks app to portrait mode (ton of issues if its put in landscape)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) => ThemeNotifier(lightTheme),
              child: MyApp(),
            ),
          ));

  //Delete the upper part and uncomment this if we do not want the app to be locked in portrait mode
  /*
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(lightTheme),
        child: MyApp(),
      ),
    );
    */
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
              var _assignments = context.watch<MyAppState>().assignments;
              _assignments.fromDb(snapshot.data?[0]?['assignments'] ?? []);
              final _assignmentCount =
                  _assignments.addCanvasAssignments(snapshot.data?[1] ?? []);

              if (_assignmentCount > 0) {
                Init.saveAssignments(_assignments.getAllAssignments());
              }

              return MyHomePage(assignmentCount: _assignmentCount);
            } else {
              return Text('loading...'); // TODO: make a loading screen
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
    // Note that assignments cannot be saved between runs of the debugger
    // Assignments can be saved when the app is reloaded
    Assignment as1 = assignments.createAssignment();
    as1.name = "Sample Assignment 1";
    as1.details =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in aliquam eros, a posuere nibh. Nullam in nisl eleifend, bibendum leo at, volutpat nulla. Vestibulum quis nisi felis. Nam a orci congue, facilisis velit vel, posuere est. Ut dolor ante, ultricies a fermentum a, iaculis a leo. Aliquam erat volutpat. Nulla a ligula ac felis iaculis euismod efficitur eu velit. Aenean finibus quis eros sed ornare. Proin fringilla, velit eget viverra tempor, elit dui lobortis orci, eu hendrerit nunc augue a mauris. Phasellus placerat bibendum lectus non feugiat.";
    as1.notes =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu enim tellus. Quisque pharetra ipsum quam, et tristique mauris pretium quis. Nulla dui diam, maximus.";
    as1.dueDate = DateTime.parse('2023-01-03 14:30:00Z');
    as1.priority = 1;
    Assignment as2 = assignments.createAssignment();
    as2.name = "Sample Assignment 2";
    as2.details = "cheese and crackers grommit";
    as2.notes = "CHEESE GROMIT! CHEESE!";
    as2.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    as2.priority = 3;
    Assignment as3 = assignments.createAssignment();
    as3.name = "Sample Assignment 3";
    as3.details =
        "The Hog Rider card is unlocked from the Spell Valley (Arena 5). He is a very fast building-targeting, melee troop with moderately high hitpoints and damage. He appears just like his Clash of Clans counterpart; a man with brown eyebrows, a beard, a mohawk, and a golden body piercing in his left ear who is riding a hog. A Hog Rider card costs 4 Elixir to deploy.";
    as3.notes = "HOOOG RIIIDAAAAAAAAAAAAAAAAAAAAAAAA";
    as3.dueDate = DateTime.parse('2023-12-15 16:00:00Z');
    as3.priority = 4;
    Assignment as4 = assignments.createAssignment();
    as4.name = "Sample Assignment 4";
    as4.details =
        "Hello, hello? Uh, I wanted to record a message for you to help you get settled in on your first night. Um, I actually worked in that office before you. I'm finishing up my last week now, as a matter of fact. So, I know it can be a bit overwhelming, but I'm here to tell you there's nothing to worry about. Uh, you'll do fine. So, let's just focus on getting you through your first week. Okay? Uh, let's see, first there's an introductory greeting from the company that I'm supposed to read. Uh, it's kind of a legal thing, you know. Um, \"Welcome to Freddy Fazbear's Pizza. A magical place for kids and grown-ups alike, where fantasy and fun come to life. Fazbear Entertainment is not responsible for damage to property or person. Upon discovering that damage or death has occurred, a missing person report will be filed within 90 days, or as soon property and premises have been thoroughly cleaned and bleached, and the carpets have been replaced.\"";
    as4.notes =
        "Hello, Internet, welcome to the 200th Episode of Game Theory! Technically it's the two hundred first and a-half episode because, we had a Mini Theory WAY WAY back on the channel a long time ago that's now privated because of reasons and then technically the Bendy Episode last week was the 200th episode but I thought this felt more appropriate because it's solving FNAF with one final MEGA Theory so the 200th Episode of Game theory!";
    as4.dueDate = DateTime.parse('2024-10-21 16:00:00Z');
    as4.priority = 2;
    //*/

    Init.saveAssignments(assignments.getAllAssignments());
  }
}

class MyHomePage extends StatefulWidget {
  final int assignmentCount;

  const MyHomePage({super.key, required this.assignmentCount});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var selectedIndex = 0;
  bool showCount = true;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (showCount && widget.assignmentCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: TextWidget(
            text: 'Added ${widget.assignmentCount} new Canvas assignments',
            multiplier: 0.7,
          )),
        );

        showCount = false;
      }
    });

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

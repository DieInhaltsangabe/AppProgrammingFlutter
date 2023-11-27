import 'dart:async';
import 'bottom_app_bar.dart';
import 'app_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuberino',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Color background = Color(0xFF1C2757);
  Color secondBackground = Color(0xFF323F68);

  int seconds = 0, minutes = 0, milliseconds = 0;
  String digitSeconds = "00", digitMinutes = "00", digitMilliseconds = "00";
  Timer? timer;
  bool started = false;
  List laps = [];


  // stop timer func
  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  // reset
  void reset() {
    timer!.cancel();
    setState(() {
      milliseconds = 0;
      seconds = 0;
      minutes = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitMilliseconds = "00";

      started = false;
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      int localMilliseconds = milliseconds + 1;
      int localSeconds = seconds;
      int localMinutes = minutes;

      if(localMilliseconds > 99) {
        if (localSeconds > 59) {
          localMinutes++;
          localSeconds = 0;
        }
        else{
          localSeconds++;
          localMilliseconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        milliseconds = localMilliseconds;
        digitSeconds = (seconds >= 10) ? "$seconds":"0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes":"0$minutes";
        digitMilliseconds = (milliseconds >= 10) ? "$milliseconds":"0$milliseconds";
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 200.0,
                        padding: EdgeInsetsDirectional.zero,
                        decoration: BoxDecoration(
                          color: secondBackground,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                  onPressed: () {},
                                  shape: StadiumBorder(side: BorderSide(color: Colors.blue),
                                  ),
                                  child: Text("Generate Scramble", style: TextStyle(color: Colors.white),)
                              ),
                            ),
                          ]
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: Text(
                          "$digitMinutes:$digitSeconds:$digitMilliseconds",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 82.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.timer,
                        style: TextStyle(
                          color: Colors.teal.shade100,
                          fontWeight: FontWeight.w600,
                          fontSize: AppSettings().fontSize,
                        ),
                      ),
                      Listener(
                        onPointerDown: (event) {
                          if(background == Color(0xFF1C2757)){
                            Timer.periodic(Duration(milliseconds: 750), (timer) {
                              background = Colors.green;
                              secondBackground = Colors.lightGreen;
                            });
                          }
                          else{
                            stop();
                            background = Color(0xFF1C2757);
                            secondBackground = Color(0xFF323F68);
                          }
                        },
                        onPointerUp: (event) {
                          if(background ==  Colors.green){
                            start();
                          }
                        },
                        child: Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: secondBackground,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ]
                )
            )
        ),
        bottomNavigationBar: BottomMenu(false, true, true),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
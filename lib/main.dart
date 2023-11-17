import 'package:firebase_core/firebase_core.dart';
import 'package:flash/navigation/bottom_tab_navigation.dart';
import 'package:flash/screen/auth/login.dart';
import 'package:flash/screen/gallery.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Login(),
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) => const Login(),
        "gallery": (BuildContext context) => const Gallery(),
        "bottomTab":(BuildContext context)=> const BottomTabNavigation()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("Hello"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

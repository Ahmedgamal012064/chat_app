import 'package:chat_firebase_app/screens/chat_screen.dart';
import 'package:chat_firebase_app/screens/register_screen.dart';
import 'package:chat_firebase_app/screens/signin_screen.dart';
import 'package:chat_firebase_app/screens/splach_screen.dart';
import 'package:chat_firebase_app/screens/welcome_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
final _auth = FirebaseAuth.instance;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
          headline5: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 24,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            fontFamily: "Tajawal",
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        primaryColor: Colors.blue[800],
        accentColor: Colors.yellow[900],
        fontFamily: "Tajawal",
      ),
      // Arabic RTL
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar", "AE"),Locale("en", "EN")],
      locale: const Locale("ar", "AE"),
      home: SplashScreen(),
      //init all routes we used
      initialRoute:  _auth.currentUser == null ? '' : chatPage.routename,
      routes: {
        '' : (context) =>  SplashScreen(),
        signIn.routename : (context)   =>  const signIn(),
        Register.routename : (context) =>  const Register(),
        chatPage.routename : (context) =>  const chatPage(),

      },
    );
  }
}


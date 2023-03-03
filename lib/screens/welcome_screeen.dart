import 'package:chat_firebase_app/screens/register_screen.dart';
import 'package:chat_firebase_app/screens/signin_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);
  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                ),
                Text('MessageMe',style: Theme.of(context).textTheme.headline5,),
              ],
            ),
            SizedBox(height: 30,),
            myButton(
               title:'SignIn',
              color: Theme.of(context).accentColor!,
              onPressed: (){
                 Navigator.pushNamed(context,
                     signIn.routename,
                 );
              },
            ),
            myButton(
              title:'SignUp',
              color: Theme.of(context).primaryColor!,
              onPressed: (){
                Navigator.pushNamed(context,
                  Register.routename,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



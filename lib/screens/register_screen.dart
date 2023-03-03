import 'package:chat_firebase_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routename = "/register";


  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("SignUp"),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(height: 50,),
              myTextField(false,TextInputType.emailAddress,'Enter Your Email',(value){
                email = value;
              }),
              SizedBox(height: 8,),
              myTextField(true,TextInputType.text,'Enter Your Password',(value){
                password = value;
              }),
              SizedBox(height: 10,),
              myButton(
                title:'Register',
                color: Theme.of(context).primaryColor!,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try{
                    final new_User = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password
                    );
                    Navigator.pushNamed(context, chatPage.routename);
                    Fluttertoast.showToast(
                      msg: "تمت التسجيل بنجاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red.withOpacity(0.4),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    setState(() {
                      showSpinner = false;
                    });
                  }catch(e){
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

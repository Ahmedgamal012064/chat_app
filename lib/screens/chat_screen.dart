import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class chatPage extends StatefulWidget {
  const chatPage({Key? key}) : super(key: key);
  static const routename = "/chat-page";

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageText;
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser(){
    try{
      final user = _auth.currentUser;
      if(user != null){
        signedInUser = user;
        print(signedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for(var msg in messages.docs){
  //     print(msg.data());
  //   }
  // }
  void getMessagesStreams() async {
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var msg in snapshot.docs){
        print(msg.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Row(
          children: [
            Image.asset('images/logo.png',height: 25,),
            SizedBox(width: 10,),
            Text('MessageMe'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context,snapshot){
                List<MatrialText> messageWidgets = [];
                if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                }
                final messages = snapshot.data!.docs.reversed;
                for(var msg in messages){
                  final messageText = msg.get('text');
                  final messageSender = msg.get('sender');
                  final currentUser =  signedInUser.email;
                  final messageWidget = MatrialText(isMe:currentUser == messageSender,text:messageText,sender:messageSender);
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    itemCount: messageWidgets.length,
                    itemBuilder: (BuildContext context, int index) {
                      messageWidgets;
                    },
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value){
                          messageText = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          hintText: "Enter your Message",
                          border: InputBorder.none,
                        ),
                      ),
                  ),
                  TextButton(
                      onPressed: (){
                        messageTextController.clear();
                        _firestore.collection('messages').add({
                          'sender' : signedInUser.email,
                          'text' : messageText,
                          'time' : FieldValue.serverTimestamp()
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}

class MatrialText extends StatelessWidget {
  final String? text;
  final String? sender;
  final bool? isMe;
  const MatrialText({this.isMe,this.text,this.sender,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: isMe! ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Text('$sender',
          style: TextStyle(
            fontSize: 12,color: Theme.of(context).accentColor
          ),),
          Material(
            elevation: 5,
            borderRadius: isMe! ? BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ) : BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: isMe! ? Theme.of(context).primaryColor : Colors.grey ,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text('$text - $sender',
                style: TextStyle(
                  fontSize: 15,
                ),),
            ),
          ),
        ],
      ),
    );
  }
}


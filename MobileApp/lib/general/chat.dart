import 'package:flutter/material.dart';
import 'package:wuoof/general/main-appbar.dart';
import '../extras/globals.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;

  User({this.id, this.name, this.imageUrl});

}

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({this.sender, this.time, this.text, this.isLiked, this.unread});

}

final User currentUser = User(id: 0, name: 'Sena', imageUrl: 'assets/images/sena.jpg');
final User yui = User(id: 1, name: 'Yui', imageUrl: 'assets/images/yui.jpg');
final User ryuu = User(id: 2, name: 'Ryuu', imageUrl: 'assets/images/ryuu.jpg');
final User suya = User(id: 3, name: 'Suya', imageUrl: 'assets/images/suya.jpg');
final User haruka = User(id: 4, name: 'Haruka', imageUrl: 'assets/images/haruka.jpg');
final User neji = User(id: 4, name: 'Neji', imageUrl: 'assets/images/neji.jpg');
final User hanabi = User(id: 4, name: 'Hanabi', imageUrl: 'assets/images/hanabi.jpg');
final User iruka = User(id: 4, name: 'Iruka', imageUrl: 'assets/images/iruka.jpg');

//Favorite Contacts
List<User> favorites = [yui, haruka, suya, hanabi, neji, iruka];

// Example chats on home screen
List<Message> chats = [
  Message(
    sender: yui,
    time: '5:30 PM',
    text: "Hola cómo estás?",
    isLiked: true,
    unread: false
  ),
  Message(
    sender: suya,
    time: '4:30 PM',
    text: "Kak jadi latihan engga?",
    isLiked: false,
    unread: false
  ),
  Message(
    sender: haruka,
    time: '5:60 PM',
    text: "Nanti uang nya sama mamah",
    isLiked: true,
    unread: true
  ),
  Message(
    sender: ryuu,
    time: '7:30 PM',
    text: "Hayuk mabar kak",
    isLiked: false,
    unread: true
  ),
  Message(
    sender: iruka,
    time: '7:30 PM',
    text: "Perhatian bagi seluruh warga agar ikut kerja bakti",
    isLiked: false,
    unread: true
  )
];

// Example chats in chat screen
List<Message> messages = [
    Message(
      sender: currentUser,
      time: '5:36 PM',
      text: "Hola cómo estás??",
      isLiked: true,
      unread: true
    ),
    Message(
    sender: yui,
    time: '5:30 PM',
    text: "Bien gracias :')",
    isLiked: true,
    unread: false
  ),
  Message(
    sender: currentUser,
    time: '5:36 PM',
    text: "Que bueno! Te parece si nos vemos en Averanda?",
    isLiked: true,
    unread: true
  ),
  Message(
    sender: yui,
    time: '5:30 PM',
    text: "Claro, a las 6:30 verdad??",
    isLiked: true,
    unread: false
  ),
  Message(
    sender: haruka,
    time: '5:36 PM',
    text: "No olvides traer el kit de medicina de Bambina (:",
    isLiked: false,
    unread: true
  ),
  Message(
    sender: currentUser,
    time: '5:36 PM',
    text: "Súper! Lo llevo y también su juguete vale?",
    isLiked: true,
    unread: true
  ),
];

class ChatScreen extends StatefulWidget {
  final User user =currentUser;
  final String guest_name;
  final String img_url;
  ChatScreen(this.guest_name, this.img_url);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
_buildMessage(Message message, bool isMe){
  final Container msg = Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: isMe 
        ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0) 
        : EdgeInsets.only(top:8.0, bottom: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        decoration: isMe ? BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0)
          )
        ) : BoxDecoration(
          color: Color(0xFFe4f1fe),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.time,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 13.0,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 8.0,)
,       Text(
              message.text,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 13.0,
                fontWeight: FontWeight.w600
              )
            ),
          ],
        ),
  );
  if (isMe){
    return msg;
  }
  return Row(
    children: <Widget>[
      msg,
    ],
  );
}
 
 _buildMessageComposer() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 8.0),
     height: 70.0,
     color: Colors.white,
     child: Row(
       children: <Widget>[
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Enviar mensaje...'
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
       ],
     ),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_yellow,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(widget.img_url),
            ),
            SizedBox(
              width: 7,
            ),
            Text(widget.guest_name)
          ],
        ),
         actions: <Widget>[
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image.asset(
          "images/facewuoof-logo.png",
          width: 35,
        ),
      )
    ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Chat-bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    }
                  ),
                )
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: MediaQuery.of(context).padding.bottom,),
              child: _buildMessageComposer(),
            )
          ],
        ),
      ),
    );
  }
}
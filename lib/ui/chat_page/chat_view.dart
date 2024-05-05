
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:tefmasys_mobile/theme/styled_colors.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/services.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.green
        ),
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: StyledColors.primaryColorDark,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
                  reverse: true,
                  itemCount: messsages.length,
                  itemBuilder: (context, index) => chat(
                      messsages[index]["message"].toString(),
                      messsages[index]["data"]))),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1.0,
            color: StyledColors.primaryColor,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: TextFormField(
              controller: messageInsert,
              decoration: const InputDecoration(
                hintText: "Enter a Message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                  //borderSide: const BorderSide(),
                ),
                // border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                  //borderSide: const BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                  //borderSide: const BorderSide(),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide.none,
                  //borderSide: const BorderSide(),
                ),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
              onChanged: (value) {},
              maxLines: 2,
            ),
            trailing: IconButton(
                icon: const Icon(
                  Icons.send,
                  size: 30.0,
                  color: StyledColors.primaryColor,
                ),
                onPressed: () {
                  if (messageInsert.text.isEmpty) {
                    print("empty message");
                  } else {
                    setState(() {
                      messsages.insert(
                          0, {"data": 1, "message": messageInsert.text});
                    });
                    response(messageInsert.text);
                    messageInsert.clear();
                  }
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                }),
          ),
          const SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/undraw_mint_tea_7su0.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Bubble(
                radius: const Radius.circular(15.0),
                color:
                    const Color.fromRGBO(23, 157, 139, 1),

                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? const SizedBox(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdgp_voice/second.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  SpeechToText speechToText = SpeechToText();

  var text = "Hold";
  var isListening = false;


  void navigate(BuildContext context){
    if (text == "second screen") {
      print("method executing.....");
      Navigator.push(context, MaterialPageRoute(builder: (context) => SecondWindow()));
      print("method done");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          glowColor: Colors.red,
          animate: isListening,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                          print(text);
                        });
                      },
                    );
                  });
                }
              }
            },
            onTapUp: (details) {
              setState(() {
                isListening = false;
              });
              speechToText.stop();
            },
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 50,
              child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 50, color: Colors.white),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Hi"),
        ),
        body: Container(
          child: Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SecondWindow()));
                },
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_3/speech_synthesis_page.dart';
import 'speech_recognition_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "語音辨識合成 Demo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpeechRecognitionPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "語音辨識",
                    style: TextStyle(fontSize: 36, color: Colors.redAccent),
                  ),
                )),
            SizedBox(height: 16,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SpeechSynthesisPage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("語音合成", style: TextStyle(fontSize: 36, color: Colors.blueAccent),),
                )),
          ],
        ),
      ),
    );
  }
}

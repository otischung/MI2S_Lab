import 'package:flutter/material.dart';
import 'API/TTS.dart';

class SpeechSynthesisPage extends StatefulWidget {
  const SpeechSynthesisPage({Key? key}) : super(key: key);

  @override
  State<SpeechSynthesisPage> createState() => _SpeechSynthesisPageState();
}

class _SpeechSynthesisPageState extends State<SpeechSynthesisPage> {
  String sentence = "";
  String displayLanguage = "國語";
  String selectedLanguage = "chinese";
  List<String> items = ["國語", "台語", "英語", "印尼語"];
  final player = SoundPlayer(); //音檔播放器

  @override
  void initState() {
    super.initState();
    player.init();
  }

  Future play(String pathToReadAudio) async {
    await player.play(pathToReadAudio);
    setState(() {
      print("Playing");
      player.isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "語音合成",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: 'sentence', prefixIcon: Icon(Icons.volume_up)),
            onChanged: (value) {
              setState(() {
                sentence = value;
              });
            },
          ),
          SizedBox(
            height: 32,
          ),
          IconButton(
            icon: Icon(Icons.volume_up,size: 30),
            onPressed: () async {
              if (sentence.isEmpty) return;
               await Text2Speech().connect(play, sentence, selectedLanguage);
            },
          ),
          DropdownButton(
            value: displayLanguage,
            icon: Icon(Icons.keyboard_arrow_down),
            onChanged: (String? value) {
              setState(() {
                if (value == "國語") {
                  displayLanguage = "國語";
                  selectedLanguage = "chinese";
                } else if (value == "台語") {
                  displayLanguage = "台語";
                  selectedLanguage = "taiwanese";
                } else if (value == "英語") {
                  displayLanguage = "英語";
                  selectedLanguage = "english";
                } else if (value == "印尼語") {
                  displayLanguage = "印尼語";
                  selectedLanguage = "indonesian";
                }
              });
            },
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

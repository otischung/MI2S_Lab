import 'package:flutter/material.dart';

import 'API/TTS.dart';

class DrugInformationPage extends StatefulWidget {
  const DrugInformationPage(
      {Key? key, required this.data, required String this.imgSrc})
      : super(key: key);

  final Map<String, dynamic> data;
  final String imgSrc;

  @override
  State<DrugInformationPage> createState() => _DrugInformationPageState();
}

class _DrugInformationPageState extends State<DrugInformationPage> {
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("藥物資訊"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.network(
                widget.imgSrc,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            IconButton(
              icon: Icon(Icons.volume_up,size: 30),
              onPressed: () async {
                if (widget.data["中文品名"].isEmpty) return;
                await Text2Speech().connect(play, widget.data["中文品名"], selectedLanguage);
              },
            ),
            Card(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  Text("中文品名", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["中文品名"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  Text("英文品名", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["英文品名"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("適應症", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["適應症"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("劑型", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["劑型"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text("包裝", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["包裝"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  Text("藥品類別", style: TextStyle(fontSize: 24))),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.data["藥品類別"],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_3/API/STT.dart';

class SpeechRecognitionPage extends StatefulWidget {
  const SpeechRecognitionPage({Key? key}) : super(key: key);

  @override
  State<SpeechRecognitionPage> createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  bool isLoadedModelList = false;
  List<String> modelList = [];
  bool isRecord = false;
  String speechRecognitionAudioPath = "";
  bool isNeedSendSpeechRecognition = false;
  String base64String = "";
  List<String> items = ["國語", "台語", "英語", "客語", "印尼語"];
  String selectedLanguage = "國語";
  String selectedModel = "mandarin";
  AudioEncoder encoder = AudioEncoder.wav;

  Future<String> askForService(String base64String, String model) {
    return STTClient().askForService(base64String, model);
  }

  @override
  void initState() {
    super.initState();
    //********* 根據設備決定錄音的encoder *********//
    if (Platform.isIOS) {
      encoder = AudioEncoder.pcm16bit;
    } else {
      encoder = AudioEncoder.wav;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "語音辨識",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 上半部
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: (isNeedSendSpeechRecognition)
                      ? FutureBuilder(
                          future: askForService(base64String, selectedModel),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              // 請求失敗，顯示錯誤
                              print('askForService() 請求失敗');
                              isNeedSendSpeechRecognition = false;
                              return const Center(
                                child: Text(
                                  '辨識失敗',
                                  style: TextStyle(fontSize: 40),
                                ),
                              );
                            } else if (snapshot.hasData) {
                              // 請求成功，顯示資料
                              print('請求成功');
                              String sentence = snapshot.data.toString();

                              isNeedSendSpeechRecognition = false;

                              return Text(
                                sentence,
                                style: const TextStyle(fontSize: 32),
                              );
                            } else {
                              // 請求未結束，顯示loading
                              print('辨識中...');
                              isNeedSendSpeechRecognition = false;
                              return const Center(
                                child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator()),
                              );
                            }
                          })
                      : const Center(
                          child: Text(
                          "語音辨識",
                          style: TextStyle(fontSize: 40),
                        )),
                ),
              ),
            ),
            // 下半部
            Center(
              child: Column(
                children: [
                  // 語音辨識
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        side: (isRecord == false)
                            ? const BorderSide(width: 5.0, color: Colors.blue)
                            : const BorderSide(width: 5.0, color: Colors.red),
                      ),
                      child: (isRecord == false)
                          ? const Icon(
                              Icons.mic,
                              size: 75,
                              color: Colors.blue,
                            )
                          : const Icon(
                              Icons.stop,
                              size: 75,
                              color: Colors.red,
                            ),
                      onPressed: () async {
                        debugPrint('Received click');
                        final record = Record();
                        if (isRecord == false) {
                          if (await record.hasPermission()) {
                            Directory tempDir = await getTemporaryDirectory();
                            speechRecognitionAudioPath =
                                '${tempDir.path}/record.wav';

                            await record.start(
                              numChannels: 1,
                              path: speechRecognitionAudioPath,
                              encoder: encoder,
                              bitRate: 128000,
                              samplingRate: 16000,
                            );
                            setState(() {
                              isRecord = true;
                              isNeedSendSpeechRecognition = false;
                            });
                          }
                        } else {
                          await record.stop();
                          var fileBytes = await File(speechRecognitionAudioPath)
                              .readAsBytes();

                          setState(() {
                            base64String = base64Encode(fileBytes);
                            isRecord = false;
                            isNeedSendSpeechRecognition = true;
                          });
                        }
                      },
                    ),
                  ),
                  DropdownButton(
                    value: selectedLanguage,
                    icon: Icon(Icons.keyboard_arrow_down),
                    onChanged: (String? value) {
                      setState(() {
                        if (value == "國語") {
                          selectedLanguage = "國語";
                          selectedModel = "mandarin";
                        } else if (value == "台語") {
                          selectedLanguage = "台語";
                          selectedModel = "Minnan";
                        } else if (value == "英語") {
                          selectedLanguage = "英語";
                          selectedModel = "EN200";
                        } else if (value == "客語") {
                          selectedLanguage = "客語";
                          selectedModel = "Hakka_v1";
                        } else if (value == "印尼語") {
                          selectedLanguage = "印尼語";
                          selectedModel = "idn_v8.0.1";
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
            )
          ],
        ));
  }
}

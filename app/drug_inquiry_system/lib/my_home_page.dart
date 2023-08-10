import 'dart:convert';
import 'package:drug_inquiry_system/drug_information_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 載入資料(DLI and DA)
  Future<Map<String, dynamic>> loadData() async {
    String jsonDLIString = await rootBundle.loadString('assets/data/DLI.json');
    String jsonDAString = await rootBundle.loadString('assets/data/DA.json');

    Map<String, dynamic> data = {
      "DLI": jsonDecode(jsonDLIString),
      "DA": jsonDecode(jsonDAString),
    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,
          foregroundColor: Theme
              .of(context)
              .colorScheme
              .onPrimary,
          title: Text(widget.title),
        ),
        // 重要 FutureBuilder
        body: FutureBuilder<Map<String, dynamic>>(
          future: loadData(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data;

              // 重要 ListView.builder
              return ListView.builder(
                itemCount: data!["DLI"].length,
                itemBuilder: (BuildContext context, int index) {
                  // 取得 圖片位址
                  String imgSrc = "";
                  bool containsKey =
                  data!["DA"].containsKey(data['DLI'][index]['中文品名']);
                  if (containsKey == true) {
                    imgSrc = data['DA'][data['DLI'][index]['中文品名']];
                    print(imgSrc);
                  } else {
                    imgSrc =
                    "https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-5529.jpg?w=2000";
                  }

                  // 重要 在App上要顯示的內容
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              DrugInformationPage(
                                  data: data['DLI'][index],
                                  imgSrc: imgSrc
                              )
                          )
                      );
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(data['DLI'][index]['中文品名']),
                              subtitle: Text(data['DLI'][index]['適應症']),
                            ),
                          ),
                          Image.network(
                            imgSrc,
                            width: 100,
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}

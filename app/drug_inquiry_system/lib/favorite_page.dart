import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DrugCardWidget.dart';
import 'drug_information_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, required this.favoriteDrugNames});
  final List<String> favoriteDrugNames;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String keyWord = "";

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
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("收藏藥物"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    keyWord = value;
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      // 刷新
                    });
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: loadData(),
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  // 判斷是否有點擊搜尋
                  List<dynamic> newData = [];
                  if (keyWord != "") {
                    for (int i = 0; i < data!['DLI'].length; i++) {
                      if (data['DLI'][i]['中文品名'].contains(keyWord)) {
                        newData.add(data['DLI'][i]);
                      }
                    }
                    data!['DLI'] = newData;
                  }

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
                        child: DrugCardWidget(
                          favoriteDrugNames: widget.favoriteDrugNames,
                          item: data['DLI'][index],
                          imgSrc: imgSrc,
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
            ),
          ),
        ],
      ),
    );
  }
}

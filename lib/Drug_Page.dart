import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'Drug_Information_Page.dart';

class DrugHomePage extends StatefulWidget {
  final String title;

  // Constructors in '@immutable' classes should be declared as 'const'.
  // const DrugHomePage({required this.title});
  // Add key to constructor
  const DrugHomePage({required this.title, Key? key}) : super(key: key);

  @override
  DrugHomePageState createState() => DrugHomePageState();
}

class DrugHomePageState extends State<DrugHomePage> {  // 同理: class _MyHomePageState extends State<MyHomePage>
  // 載入資料(DLI and DA)
  Future<Map<String, dynamic>> loadData() async {
    String jsonDLIString = await rootBundle.loadString('assets/data/DLI.json');
    // DA.json 裡面是網址，所以手機模擬器也要連上wi-fi才能連到網路抓圖片
    String jsonDAString = await rootBundle.loadString('assets/data/DA.json');

    Map<String, dynamic> data = {
      "DLI": jsonDecode(jsonDLIString),
      "DA": jsonDecode(jsonDAString),
    };

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
            primarySwatch: Colors.pink,  // 設置主題的主要顏色為粉紅色
            appBarTheme: const AppBarTheme(backgroundColor: Colors.pink)  // 設置 AppBar 的背景色為粉紅色
        ),
      child: Scaffold(
          backgroundColor: Colors.pink,  // 添加這一行
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            title: Text(widget.title),  // Now widget.title refers to the title passed to the DrugHomePage widget.
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
                    // data!["DA"] 不需要!
                    bool containsKey = data["DA"].containsKey(data['DLI'][index]['中文品名']);
                    if (containsKey == true) {
                      imgSrc = data['DA'][data['DLI'][index]['中文品名']];
                    } else {
                      imgSrc =
                      // 預設圖片
                      "https://blog.thomasnet.com/hubfs/shutterstock_774749455.jpg";
                    }

                    // 重要 手勢感測元件
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrugInformationPage(
                              data: data['DLI'][index],
                              imgSrc: imgSrc,
                            ),
                          ),
                        );
                      },
                      // 重要 在App上要顯示的內容
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(data['DLI'][index]['英文品名'],
                                            style: const TextStyle(fontWeight: FontWeight.bold
                                            )),  // 添加這一行),
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
                return const CircularProgressIndicator();
              }
            },
          )),
    );
  }
}
import 'package:flutter/material.dart';

class DrugInformationPage extends StatelessWidget {
  const DrugInformationPage(
      {Key? key, required this.data, required String this.imgSrc})
      : super(key: key);

  // 以下為單一個藥品的資訊 & 位置
  final Map<String, dynamic> data;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text("藥物資訊"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.network(
              imgSrc,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
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
                            child: Text("中文品名", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["中文品名"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("英文品名", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["英文品名"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("適應症", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["適應症"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("副作用", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["副作用"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("劑型", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["劑型"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("常見用量", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["常見用量"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text("注意事項", style: TextStyle(fontSize: 12))),
                        Expanded(
                          flex: 3,
                          child: Text(
                            data["注意事項"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
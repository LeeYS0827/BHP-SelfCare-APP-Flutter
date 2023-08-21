import 'package:flutter/material.dart';
import 'Score_History_DB.dart';
import 'package:fl_chart/fl_chart.dart';
import 'Score_History_Chart_Page.dart';

// 使用 Flutter 框架來定義一個具有狀態（State）的小部件，名稱為 ScorePage
// 這個小部件的主要功能是顯示分數頁面
//通過在構造函式中使用 key，可以對小部件進行識別和管理。內部狀態由 ScorePageState 類別管理
//並且當創建 ScorePage 小部件時，會返回一個 ScorePageState 實例，用於跟踪和管理小部件的內部狀態
class ScorePage extends StatefulWidget {  // ScorePage 是一個繼承自 StatefulWidget 的類別，表示這是一個具有內部狀態的小部件
  const ScorePage({Key? key}) : super(key: key); // 是該小部件的構造函式，並通過 key 參數調用了父類的構造函式
  // 這個參數是可選的，用於協助小部件在 Flutter 應用程式中識別和管理

  @override
  ScorePageState createState() => ScorePageState();  //  createState(): 是一個用於創建內部狀態的方法
  // 這個方法返回了一個 ScorePageState 的實例，用於管理 ScorePage 小部件的內部狀態
}

// 定義了一個 Dart 類別 Question，用於封裝表示問題的數據
// 其中包含每個問題的詳細信息(包括問題內容、選項和鍵值)，然後在ScorePageState中創建了一個questions列表，其中包含所有的問題
// 這種設計可以方便地將問題的相關數據組織起來，例如: 可以將多個 Question 對象組成一個問題集合，用於測驗或問卷調查等應用場景
class Question {  // 是一個自定義 Dart 類別，代表一個問題的數據結構
  final String question;  // 是一個不可變的屬性，代表問題的文字描述
  final List<String> options;  // 是一個不可變的屬性，代表問題的選項列表。選項以字符串的形式存儲在列表中
  final String key;  // 是一個不可變的屬性，代表問題的唯一鍵值。這可以用於識別和查找特定的問題

  // 是該類別的構造函式，接收問題、選項和鍵值作為必要的參數
  // 通過這個構造函式，可以創建一個 Question 對象，並初始化其中的屬性
  Question({required this.question, required this.options, required this.key});
}

// 主程式
// 定義了一個名為 ScorePageState 的狀態類別，該狀態類別用於實現分數頁面的功能
// 這個頁面包括多個問題，每個問題都有選項供用戶選擇，並根據用戶的選擇計算症狀總分
// 此外，它還提供了保存分數和日期，以及查看分數歷史圖表的功能
class ScorePageState extends State<ScorePage> {
  // 存儲不同問題的分數。每個問題都有一個唯一的鍵（key），對應到用戶的選擇分數
  Map<String, int> scores = {
    'Q1': 0,
    'Q2': 0,
    'Q3': 0,
    'Q4': 0,
    'Q5': 0,
    'Q6': 0,
    'Q7': 0,
  };

  // 默認背景顏色為黃色
  Color backgroundColor = Colors.yellow;

  // 存儲多個問題的列表，每個問題都由一個 Question 對象表示，包括問題文本、選項和鍵
  List<Question> questions = [
    Question(question: 'Q1: 排尿流速變慢、細小無力?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q1'),
    Question(question: 'Q2: 解尿時需借助肚子出力?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q2'),
    Question(question: 'Q3: 排尿時，尿流會中斷再繼續?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q3'),
    Question(question: 'Q4: 排尿完畢卻仍有尿液未排空的感覺?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q4'),
    Question(question: 'Q5: 排尿完畢未滿兩小時再去排尿的狀況?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q5'),
    Question(question: 'Q6: 難以忍受需立即排尿的感受?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q6'),
    Question(question: 'Q7: 在夜晚入睡期間，需要起床小便幾次?', options: ['從來沒有', '幾乎沒有', '少於一半', '大約一半', '大於一半', '幾乎總是'], key: 'Q7'),
  ];

  // ScoreHistoryDB _scoreHistoryDB 用於處理分數歷史數據庫的操作，包括保存分數和日期，以及查詢分數歷史數據
  ScoreHistoryDB _scoreHistoryDB = ScoreHistoryDB.instance; // 更改為單例模式

  // saveScoreAndDate() 方法用於保存分數和日期到數據庫
  void saveScoreAndDate(int totalScore) async {
    DateTime currentDate = DateTime.now();
    String formattedDate = currentDate.toLocal().toIso8601String(); // Convert to ISO 8601 format
    await _scoreHistoryDB.openDB();
    await _scoreHistoryDB.insertScore(totalScore, formattedDate);
  }

  // getScoreHistoryForChart() 方法用於獲取分數歷史數據，以供顯示在分數歷史圖表中
  Future<Map<String, dynamic>> getScoreHistoryForChart() async {
    List<Map<String, dynamic>> scoreHistory = List.from(await _scoreHistoryDB.getAllScores());
    // Sort the scores by date and only take the latest score for each date
    scoreHistory.sort((a, b) => b['measurementDate'].compareTo(a['measurementDate']));
    Map<String, int> uniqueScores = {};
    for (var entry in scoreHistory) {
      if (!uniqueScores.containsKey(entry['measurementDate'])) {
        uniqueScores[entry['measurementDate']] = entry['totalScore'];
      }
    }
    List<FlSpot> data = [];
    List<String> dates = [];
    int index = 0;
    for (var entry in uniqueScores.entries) {
      // print("entry: ${entry}");
      data.add(FlSpot(index.toDouble(), entry.value.toDouble()));
      dates.add(entry.key);
      index++;
    }
    return {'data': data, 'dates': dates};
  }


  @override
  // build() 方法用於構建分數頁面的 UI，包括問題列表、症狀總分顯示、儲存按鈕和查看分數歷史圖表按鈕
  // '評分頁面', 症狀總分, 儲存, 查看分數歷史圖表
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // primaryColor: const Color(0xFFC2185B),  // 使用自定義顏色作為主要顏色
          primarySwatch: Colors.pink,
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFC2185B))  // 使用自定義顏色作為 AppBar 的背景色
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: const Text('國際攝護腺症狀評分表: IPSS')),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,  // This will center the children vertically
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  var question = questions[index];
                  return buildQuestion(
                    question.question,
                    question.options,
                        (int score) => setState(() => scores[question.key] = score),
                    question.key,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '症狀總分: ${scores.values.reduce((a, b) => a + b)}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '症狀嚴重程度: ${scores.values.reduce((a, b) => a + b) <= 7 ? '輕度' : (scores.values.reduce((a, b) => a + b) <= 19 ? '中度' : '重度')}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,  // This will center the children horizontally
              children: [
                ElevatedButton(
                  onPressed: () {
                    saveScoreAndDate(scores.values.reduce((a, b) => a + b));

                    // 觸發背景顏色重新渲染
                    int currentScore = scores.values.reduce((a, b) => a + b);
                    if (currentScore <= 7) {
                      backgroundColor = Colors.yellowAccent;
                    } else if (currentScore <= 19) {
                      backgroundColor = Colors.lightGreenAccent;
                    } else {
                      backgroundColor = Colors.redAccent;
                    }
                    setState(() {});  // 觸發小部件的重新渲染
                  },
                  child: Text('儲存'),
                ),
                SizedBox(width: 10.0),  // 這將在按鈕之間添加10像素的水平間距
                ElevatedButton(
                  onPressed: () async {
                    var result = await getScoreHistoryForChart();
                    List<FlSpot> data = result['data'] as List<FlSpot>;
                    List<String> dates = result['dates'] as List<String>;

                    Navigator.of(context).push(  // pushReplacement(使用這個的話會沒有返回建) => push
                      MaterialPageRoute(
                        builder: (context) => ScoreHistoryChartPage(data: data, dates: dates),
                      ),
                    );
                    // 使用 Navigator.of(context).pushReplacement() 方法時，它會替換當前的路由，而不是將新的路由推到堆疊上。因此，當你進入新的頁面時，堆疊中不會有前一個頁面，所以 AppBar 不會自動提供返回按鈕。
                    // 相反，如果你使用 Navigator.of(context).push() 方法，新的頁面會被推到堆疊的頂部，前一個頁面仍然存在於堆疊中。因此，當你進入新的頁面時，AppBar 會自動提供返回按鈕，允許你返回到前一個頁面。
                  },
                  child: Text("查看測驗歷史圖"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // buildQuestion() 方法用於構建一個問題的 UI，包括問題文本和選項列表，用戶可以通過點擊選項來選擇分數
  Widget buildQuestion(String question, List<String> options, Function(int) onOptionSelected, String currentQuestion) {  // 選項都列出來，讓使用者點選
    return Column(
      children: [
        Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...options.map((option) {
          int optionScore = options.indexOf(option);  // 第一個選項為0分, 若 options.indexOf(option) + 1: 第一個選項為1分
          return ListTile(
            // contentPadding: EdgeInsets.symmetric(vertical: -50),  // Adjust padding here
            title: Text(option),
            leading: Radio(
              value: optionScore,
              groupValue: scores[currentQuestion],
              onChanged: (int? value) {
                if (value != null) {
                  setState(() {
                    scores[currentQuestion] = value;
                  });
                  onOptionSelected(value);
                }
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  // 20230819  縮小行距(但效果不好)
  // Widget buildQuestion(String question, List<String> options, Function(int) onOptionSelected, String currentQuestion) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  //       ...options.map((option) {
  //         int optionScore = options.indexOf(option);
  //         return Container(
  //           margin: EdgeInsets.only(top: 0.2, bottom: 0.2),  // Adjust this for desired spacing
  //           child: Row(
  //             children: [
  //               Radio(
  //                 value: optionScore,
  //                 groupValue: scores[currentQuestion],
  //                 onChanged: (int? value) {
  //                   if (value != null) {
  //                     setState(() {
  //                       scores[currentQuestion] = value;
  //                     });
  //                     onOptionSelected(value);
  //                   }
  //                 },
  //               ),
  //               Text(option),
  //             ],
  //           ),
  //         );
  //       }).toList(),
  //     ],
  //   );
  // }



  // buildQuestionWithMenu() 方法是 buildQuestion() 方法的一個變體，使用彈出菜單的方式來選擇分數
  Widget buildQuestionWithMenu(String question, List<String> options, Function(int) onOptionSelected, String currentQuestion) {
    return Row(
      children: [
        Expanded(
            child: Text(question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        ),
        PopupMenuButton<int>(
          onSelected: (int value) {
            onOptionSelected(value);
          },
          itemBuilder: (BuildContext context) {
            return options.map((String option) {
              int optionScore = options.indexOf(option) + 1;
              return PopupMenuItem<int>(
                value: optionScore,
                child: Text(option),
              );
            }).toList();
          },
          child: const Icon(Icons.arrow_drop_down, size: 24.0),  // Icon to indicate a dropdown
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'Drug_Page.dart';
import 'Score_Page.dart'; // 引用score_page
import 'Score_History_DB.dart';
import 'Disease_Page.dart';

void main() async {
  // Ensure all Flutter widgets are bound.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database.
  await ScoreHistoryDB.instance.database;

  // Now, run the app.
  runApp(MyApp());
}


// 總的來說，MyApp 提供了全域設定
// MyHomePage 提供了一個可以變更狀態的框架
// _MyHomePageState 則維護和更新那些狀態，使得 UI 可以對用戶的互動做出回應
class MyApp extends StatelessWidget {  // 是一個 StatelessWidget，表示它不會改變狀態
  const MyApp({super.key});

  // This widget is the root of your application.
  // 這個類別用 build 方法來產生 MaterialApp，並設定了一些全域的設定(如:主題色彩與主頁面)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(  // 定義了全域主題
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),  // 主題色
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),  // 指定了應用程式啟動時首先會顯示的視窗（在這裡是 MyHomePage）
    );
  }
}

class MyHomePage extends StatefulWidget {  // 是一個 StatefulWidget，表示它的部分資料可能改變，並且該改變會影響到該元件的 UI
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. stateful, meaning that it has a State object (defined below)
  // that contains fields that affecthow it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  // 這個類別包含了一個 title 屬性，這是一個從父元件傳遞下來並且不會變更的字串
  final String title;

  @override
  // 定義了 createState 方法，該方法會回傳一個 _MyHomePageState 物件，該物件維護了與 MyHomePage 有關的狀態
  // 該方法會回傳一個 _MyHomePageState 物件，該物件維護了與 MyHomePage 有關的狀態
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  // Define pages here.
  final List<Widget> _pages = <Widget>[  // use the final keyword if your list is not going to change after initialization.
    const DiseasePage(),  // 首頁的第1個按鈕: Disease，點進去的介面
    // Constructors in '@immutable' classes should be declared as 'const'.
    const DrugHomePage(title: 'Drug List'), // 首頁的第2個按鈕: Medicine，點進去的介面(使用 DrugHomePage() 呈現)
    const ScorePage(),  // 首頁的第3個按鈕: Records，點進去的介面(使用 ScorePage() 呈現)
  ];

  void navigateToHistoryPage(BuildContext context) {  // navigateToHistoryPage 函式: 導航到一個歷史記錄頁面的操作
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScoreHistoryDBPage()),  // 這個設定，在所有頁面都可以看到這個按鈕
    );
  }

  @override
  Widget build(BuildContext context) {  //  build 方法，該方法會在 UI 需要被重新繪製時被調用
    return Scaffold(  // Scaffold 是 Flutter 提供的一個基本的 UI 結構，它包含了 App Bar、Body 區域、Bottom Navigation Bar 等元素
      bottomNavigationBar: NavigationBar(  // bottomNavigationBar: 是一個底部導航欄，顯示在 Scaffold 的底部，用於在不同的頁面之間切換
        // NavigationBar 是一個自定義的小部件，它負責顯示底部導航欄中的不同選項
        // 每個選項都包括一個圖標和一個標籤，並且在被選中時可以顯示不同的圖標。
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        }, // 當底部導航欄的某個選項被選中時
        // onDestinationSelected 方法會被調用，這會觸發一個狀態更新，將 currentPageIndex 設置為所選的索引，以便切換到對應的頁面
        selectedIndex: currentPageIndex,  // selectedIndex 屬性用於指定當前選中的選項索引
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.ads_click), // 點選後圖片改變
            icon: Icon(Icons.sick),
            label: 'Disease',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.ads_click), // 點選後圖片改變
            icon: Icon(Icons.medication_liquid),
            label: 'Medicine',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.ads_click), // 點選後圖片改變
            icon: Icon(Icons.event_note),
            label: 'Records',
          ),
        ],
      ),
      // _pages 是一個包含不同頁面內容的列表，currentPageIndex 用於索引這個列表，顯示當前選中的頁面。
      body: Stack(children: [_pages[currentPageIndex],
      Positioned(
        right: 16.0,  // 這是 FloatingActionButton 的默認右側邊距
        bottom: 5.0,  // 下移 FloatingActionButton
        child: FloatingActionButton(  // floatingActionButton 是一個浮動操作按鈕
          // 當按下時，會執行 navigateToHistoryPage 函式，這可能是導航到一個歷史記錄頁面的操作。
          onPressed: () {
            navigateToHistoryPage(context);
          },
          child: Icon(Icons.history),
        ),
      ),
    ],
    ));
  }
}



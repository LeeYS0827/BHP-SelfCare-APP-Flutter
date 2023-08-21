import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

//  Flutter 框架來定義一個狀態(State)ful 小部件（Widget），名稱為 ScoreHistoryDBPage
// 這個小部件擁有一個 _ScoreHistoryDBPageState 類(下面: class _ScoreHistoryDBPageState extends)的內部狀態，用於管理該小部件的狀態變化。
class ScoreHistoryDBPage extends StatefulWidget {
  @override
  _ScoreHistoryDBPageState createState() => _ScoreHistoryDBPageState();
}

// 這段程式碼定義了一個狀態類 _ScoreHistoryDBPageState，該狀態用於在 UI 上顯示分數歷史記錄的頁面
// 從 ScoreHistoryDB 數據庫中獲取數據並以適當的方式顯示在 UI 上。這是一個展示數據庫內容的常見模式。
class _ScoreHistoryDBPageState extends State<ScoreHistoryDBPage> {
  // 這段程式碼定義了一個狀態類 _ScoreHistoryDBPageState
  // 這個狀態類別是之前提到的 ScoreHistoryDBPage (上面的 class ScoreHistoryDBPage) 小部件的內部狀態，它的目的是用來顯示分數歷史記錄的頁面。
  late ScoreHistoryDB _scoreHistoryDB;

  @override
  void initState() {
    // 是一個生命週期方法，當這個狀態對象被創建時會自動調用
    super.initState();
    // Use singleton instance
    _scoreHistoryDB = ScoreHistoryDB
        .instance; // _scoreHistoryDB 變數被初始化為 ScoreHistoryDB.instance
    // 這表示使用單例模式的方式來獲取 ScoreHistoryDB 的實例，用於與分數歷史記錄數據庫進行交互
  }

  @override
  Widget build(BuildContext context) {
    // build() 方法是另一個生命週期方法，當 UI 需要被構建時會自動調用
    return Scaffold(
      // 在這個方法中，Scaffold 小部件被返回，該小部件包含了一個 AppBar 和 Body 區域。
      appBar: AppBar(
        // 應用程式的頂部導航欄，標題被設置為 "Score History"
        title: Text('Score History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // body 區域是 FutureBuilder 小部件
        // 它根據 _scoreHistoryDB.getAllScores() 方法返回的 Future 來構建 UI
        future: _scoreHistoryDB.getAllScores(),
        builder: (context, snapshot) {
          // 在 FutureBuilder 的 builder 方法中，根據不同的 snapshot 狀態來構建不同的 UI
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 如果連接狀態為等待中（ConnectionState.waiting）
            return CircularProgressIndicator(); // 則顯示一個進度指示器
          } else if (snapshot.hasData && snapshot.data!.length > 0) {
            // 如果 snapshot 中有數據且數據長度大於 0
            final scoreList = snapshot.data!;
            return ListView.builder(
              // 則將數據解析並顯示在一個 ListView 中，每個分數記錄都作為 ListTile 顯示
              itemCount: scoreList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Score: ${scoreList[index]['totalScore']}'),
                  subtitle:
                      Text('Date: ${scoreList[index]['measurementDate']}'),
                );
              },
            );
          } else {
            // 如果 snapshot 中沒有數據，則顯示 "No history records available." 的文字。
            return Text('No history records available.');
          }
        },
      ),
    );
  }
}

// 這段程式碼定義了一個名為 ScoreHistoryDB 的類別
// 該類別負責管理和處理分數歷史記錄的數據庫操作，包括數據庫的創建、插入分數、獲取所有分數等
// 並使用單例模式確保只有一個數據庫實例存在。這樣的設計可以方便地在應用程式中管理和操作分數歷史記錄的數據
class ScoreHistoryDB {
  // ScoreHistoryDB 是一個類別，用於管理分數歷史記錄的數據庫操作
  static final ScoreHistoryDB _instance = ScoreHistoryDB
      ._privateConstructor(); // _instance 是一個靜態屬性，用於保存 ScoreHistoryDB 的單例實例
  static Database? _database; // _database 是一個靜態屬性，用於保存數據庫實例

  // Make this a singleton class
  ScoreHistoryDB._privateConstructor(); // ScoreHistoryDB._privateConstructor() 是一個私有的構造函式
  // 確保只有在內部才能創建 ScoreHistoryDB 的實例

  static ScoreHistoryDB get instance =>
      _instance; // ScoreHistoryDB get instance 是一個靜態方法，用於獲取 ScoreHistoryDB 的單例實例

  Future<Database> get database async {
    // database 是一個異步 getter 方法，用於獲取數據庫實例
    if (_database != null) return _database!; // 如果 _database 不為空，則直接返回
    _database = await openDB(); // 否則打開數據庫
    return _database!;
  }

  // openDB() 是一個異步方法，用於打開數據庫
  Future<Database> openDB() async {
    print("Opening database...");
    _database = await openDatabase(
      // 它在數據庫創建時執行一些初始化操作，例如創建分數記錄表
      'score_history.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS scores (
            id INTEGER PRIMARY KEY,
            totalScore INTEGER,
            measurementDate TEXT
          )
        ''');
      },
    );
    print("Database opened successfully");
    return _database!;
  }

  // insertScore() 是一個異步方法，用於插入分數記錄到數據庫
  // 這個函式返回一個 Future 物件，表示這個操作是一個非同步操作，並且不會返回任何值
  // insertScore：函式的名稱，表示這是一個用來插入分數紀錄的函式
  // (int totalScore, String measurementDate)：函式的兩個參數，分別是症狀總分數和測量日期。將這些值作為引數傳遞給函式
  // await 關鍵字：在 Dart 中，用於等待非同步操作儲存的關鍵字
  // 它將使程式碼等待數據庫插入操作儲存，然後再繼續執行後續的程式碼
  // _database 是類中的一個初始化的數據庫連接
  Future<void> insertScore(int totalScore, String measurementDate) async {
    // print("Inserting score: $totalScore on ${measurementDate}");
    // print("Inserting score: $totalScore on ${measurementDate.substring(0, 10)}");
    // List<Map<String, dynamic>> tableInfo =
    //     await _database!.rawQuery("PRAGMA table_info(scores)");
    // for (var column in tableInfo) {  // 列印 table 的欄位名稱
    //   print("Column name: ${column['name']}");
    // }
    // 'scores' 是資料表的名稱，'measurementDate = ?' 是查詢的條件
    // 表示在 'scores' 表中搜尋 'SUBSTR(measurementDate, 1, 10) = ?' 值等於 whereArgs 變數的記錄
    final existingRecord = await _database!.query(
      'scores',
      where: 'SUBSTR(measurementDate, 1, 10) = ?',
      whereArgs: [
        measurementDate.substring(0, 10)
      ], // 對於 SQLite 來說，日期的字串是以 0 為基底的索引
    );
    // print("existingRecord: $existingRecord");

    if (existingRecord.isNotEmpty) {
      // 如果結果不為空，表示數據庫中已經存在該日期的記錄
      await _database!.update(
        // 如果存在相同日期的記錄，則使用 _database!.update() 方法來更新該日期的記錄
        'scores',
        // {'totalScore': totalScore},
        {'totalScore': totalScore, 'measurementDate': measurementDate},
        // where: 'measurementDate = ?',
        // whereArgs: [measurementDate],
        where: 'SUBSTR(measurementDate, 1, 10) = ?',
        whereArgs: [measurementDate.substring(0, 10)],
      );
      print("Score updated successfully");
    } else {  // 如果不存在相同日期的記錄，則使用 _database!.insert() 方法來插入一條新的記錄
      await _database!.insert(  // 這行程式碼呼叫 _database 中的 insert 方法(由數據庫庫或框架提供的內建方法)
        // 將一個新的分數紀錄插入到 'scores' 表中。這個表是儲存分數紀錄的地方。
        // 'totalScore' 和 'measurementDate' 是列名，totalScore 和 measurementDate 則是你傳遞給函式的參數
        'scores',
        {'totalScore': totalScore, 'measurementDate': measurementDate.substring(0, 10)},
      );
      print("Score inserted successfully");
    }
  }

  // getAllScores() 是一個異步方法，用於獲取所有分數記錄，按照 id 由大到小排列
  // 實現在回傳結果中去除重複日期，並僅保留當天時間最新的記錄，循以下步驟：
  // 1.使用 GROUP BY 來按日期分組 & 使用 MAX 函數找出每個日期分組中的最大時間，即當天最新的時間。
  // 2.使用 JOIN 來連接原始資料表和包含最大時間的結果，以選取對應的記錄。
  Future<List<Map<String, dynamic>>> getAllScores() async {
    print("Fetching all scores...");
    // 1.建立子查詢，找出每個日期分組中的最新時間 (id數值最大的那筆)
    String subquery = '''
    SELECT SUBSTR(measurementDate, 1, 10) AS date, MAX(id) AS lastId
    FROM scores
    GROUP BY date
    ''';

    // 2.使用子查詢和 JOIN 來取得最新的記錄, 不能left join
    String query = '''
    SELECT s.*
    FROM scores s
    JOIN ($subquery) t ON SUBSTR(s.measurementDate, 1, 10) = t.date AND s.id = t.lastId
    ORDER BY s.id DESC
    ''';
    List<Map<String, dynamic>> result = await _database!.rawQuery(query);
    print("Fetched ${result.length} scores");
    return result;
  }
}

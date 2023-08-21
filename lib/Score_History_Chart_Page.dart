import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'Date_Range_Picker_Widget.dart';

// 義了一個名為 ScoreHistoryChartPage 的狀態(State)ful小部件
// 用於顯示分數歷史的圖表頁面。這個小部件將在 UI 中呈現使用者分數的變化趨勢
// 通過將分數數據和日期作為參數傳遞，可以在該小部件中建立一個相應的圖表，並呈現出用戶的分數變化情況
class ScoreHistoryChartPage extends StatefulWidget {  // ScoreHistoryChartPage 是一個繼承自 StatefulWidget 的類別
  // 表示這是一個具有內部狀態的小部件
  final List<FlSpot> data;  // 用於存儲分數歷史數據的 FlSpot 列表，FlSpot 是用於 Flutter Chart 庫的類別，表示圖表中的一個數據點
  final List<String> dates;  // 存儲每個數據點相對應的日期的列表

  // 這個小部件的構造函式，接收數據和日期作為必要的參數
  ScoreHistoryChartPage({required this.data, required this.dates});

  @override
  // _ScoreHistoryChartPageState 是 ScoreHistoryChartPage 的內部狀態類別
  // 該狀態類別負責實現該小部件的具體 UI 和功能
  _ScoreHistoryChartPageState createState() => _ScoreHistoryChartPageState();
}

// 定義了 ScoreHistoryChartPage 的內部狀態類別 _ScoreHistoryChartPageState
// 該狀態類別用於實現分數歷史圖表頁面的具體 UI 和功能(顯示分數隨時間變化的趨勢)
// '分數歷史圖表',
class _ScoreHistoryChartPageState extends State<ScoreHistoryChartPage> {
  // widget.data 是 final 且不能被重新賦值。我們需要使用一個狀態變量來存儲和修改數據 => 改成 _data
  late List<FlSpot> _data;  // Add this line
  late List<String> _date;
  // late List<FlSpot> widget.data;
  // List<FlSpot> _data = [];

  @override
  void initState() {
    super.initState();
    // 這邊進行反轉數據是沒有用的，因為這邊是初始化，正式更新在下方，請搜尋: .reversed.toList()
    // Initialize _data here
    // Directly reverse the _date and _data lists during initialization
    _date = widget.dates.reversed.toList();
    _data = List<FlSpot>.generate(widget.data.length, (index) {
      return FlSpot(index.toDouble(), widget.data[widget.data.length - 1 - index].y);
    });
  }

  @override
  Widget build(BuildContext context) {  // build() 方法用於構建分數歷史圖表頁面的 UI
    return Scaffold(
      appBar: AppBar(title: Text('分數歷史圖表')),
      body: Column(
        children: [
          DateRangePickerWidget(  //  是一個自定義小部件，可以在這個 UI 中用於選擇日期範圍
            // 當用戶選擇日期範圍時，你可以根據選擇的日期範圍過濾數據並更新圖表
            // onDateRangeSelected: (startDate, endDate) {},

            // onDateRangeSelected:：這是你在 DateRangePickerWidget 中設定的一個回調函式
            // 當使用者選擇日期範圍時，這個回調函式將被觸發
            onDateRangeSelected: (startDate, endDate) {  // 這個回調函式接受兩個參數 startDate 和 endDate
              // print("onDateRangeSelected called with $startDate to $endDate");  // 有印出來
              // 分別表示使用者選擇的開始日期和結束日期
              if (startDate != null && endDate != null) {  // 這個條件確保只有在 startDate 和 endDate 都存在的情況下，才執行後續的處理
                // Filter data based on the selected date range.
                // 因為我之前建議的更新方式使用了局部變量 data，但在 ScoreHistoryChartPage 的上下文中
                // 這些數據是作為 widget.data 存在的。同樣地，dates 也應該是 widget.dates
                print("Filtering data from $startDate to $endDate");
                print("Total data points before filtering: ${widget.data.length}");
                List<FlSpot> filteredData = widget.data.where((spot) {
                  // 這裡使用 widget.dates 從 spot 的 x 座標獲取日期並解析為 DateTime
                  DateTime spotDate = DateTime.parse(widget.dates[spot.x.toInt()]);
                  // 這個條件確保數據點的日期在選擇的日期範圍內。如果符合這個條件，則該數據點被保留
                  return spotDate.isAfter(startDate) && spotDate.isBefore(endDate.add(Duration(days: 1)));
                }).toList();
                print("Data points after filtering: ${filteredData.length}");
                // if (filteredData.isNotEmpty) {
                //   print("First filtered data point: ${filteredData[0]}");
                // }
                print("Final filtered data: $filteredData");

                // 新增過濾後的日期資料: filteredDate
                List<String> filteredDate = widget.dates.where((spot) {
                  // 這裡使用 widget.dates 從 spot 的 x 座標獲取日期並解析為 DateTime
                  DateTime spotDate = DateTime.parse(spot);
                  // 這個條件確保數據點的日期在選擇的日期範圍內。如果符合這個條件，則該數據點被保留
                  return spotDate.isAfter(startDate) && spotDate.isBefore(endDate.add(Duration(days: 1)));
                }).toList();
                print("Data points after filtering: ${filteredData.length}");
                print("Datesss points after filtering: ${filteredDate.length}");
                print("Final filteredDate: ${filteredDate}");
                print("Final filteredDate.reversed.toList(: ${filteredDate.reversed.toList()}");


                // 在過濾完數據後，你使用 setState 來更新 _data，這將觸發 UI 的重新構建，以顯示新的折線圖
                setState(() {
                  // Reverse the _data list and recalculate the x values based on the index
                  _data = filteredData;
                  // Reverse the _data list and recalculate the x values based on the index
                  _data = List<FlSpot>.generate(filteredData.length, (index) {
                    return FlSpot(index.toDouble(), filteredData[filteredData.length - 1 - index].y);
                  });
                  _date = filteredDate.reversed.toList();  // 在這邊才順利反轉數據

                  // print("_data: ${_data}");
                  // print("Printing contents of _data:");
                  // for (var spot in _data) {
                  //   print("X: ${spot.x}, Y: ${spot.y}");
                  // }
                });
              }
            },
          ),
          Expanded(  // Expanded 小部件用於佔滿剩餘的可用空間，並在內部放置了一個 AspectRatio 小部件，用於確保圖表的寬高比例
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AspectRatio(
                aspectRatio: 0.8,
                // 使用了 LineChart 小部件來顯示折線圖
                // 該圖表會根據提供的資料（widget.data）和日期（widget.dates）來顯示分數隨時間變化的情況
                child: LineChart(  // 這是一個 LineChart 小部件的建構函式，接受一個 LineChartData 物件作為參數，用來配置折線圖的外觀和數據
                  LineChartData(  // 這是一個 LineChartData 的建構函式，它用來配置折線圖的各種屬性，包括標題、軸範圍、線條等
                    // titlesData:：這個屬性用來定義標題的相關設定，包括底部標籤和左側標籤
                    titlesData: FlTitlesData(
                      show: true,
                      // bottomTitles:：底部標籤的相關設定，用來顯示日期
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        // 使用 getTitles 函式來定義底部標籤的顯示方式
                        // 整個程式碼行的目的是從 _date 串列中選擇特定索引位置的日期時間字串，然後擷取其中的日期部分（即 MM-DD），作為回傳值
                        getTitles: (value) {
                          // value: 表示索引的浮點數值。在您的上下文中，value 被用作索引
                          // 用於存取 _date 串列中特定的日期時間字串

                          // value.toInt() % 10 == 0 // 每隔 10 個點
                          // value.toInt() >= 0  // 每筆日期都顯示
                          // 只有在某些特定條件下（每隔 10 個點或低於日期數量）才顯示日期的月份和日期部分
                          if (value.toInt() % 2 == 0 && value.toInt() < _data.length) {  // 這裡的3可以根據需要調整
                            // widget.dates => _date
                            // print("value: $value");
                            // print("_date[value.toInt()].substring(5, 10): $_date[value.toInt()].substring(5, 10)");
                            return _date[value.toInt()].substring(5, 10);  // Display only month and day (MM-DD)
                            // .toInt()：這是將浮點數轉換為整數的方法。由於索引應該是整數，因此您可能會將浮點索引值轉換為整數，以確保正確存取串列
                            // _date[value.toInt()]：這部分的結果是從 _date 串列中選擇特定索引位置的日期時間字串
                          }
                          return '';
                        },
                        margin: 8,
                      ),

                      // leftTitles 屬性定義左側的標籤，顯示整數分數
                      leftTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitles: (value) {
                          return value.toInt().toString();  // Display score as integer
                        },
                        margin: 12,
                      ),
                    ),

                    // borderData:：這個屬性用來定義圖表的邊界線相關設定，例如邊界線的顏色和寬度
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: const Color(0xff37434d), width: 1),
                    ),
                    // minX 和 maxX 定義了 X 軸的最小值和最大值  注意: 這邊應傳選擇的參數(開始日期&結束日期)
                    minX: -1,
                    // 通過 widget.dates.length 設置最大值，確保 X 軸能夠顯示所有日期
                    // widget.dates => _date
                    maxX: (_date.length + 1).toDouble(),

                    // minY 和 maxY 定義了 Y 軸的最小值和最大值，Y 軸的最大值是數據中最大的分數
                    minY: 0,
                    maxY: 36,
                    // maxY: widget.data.map((e) => e.y).reduce((a, b) => a > b ? a : b),  // 以資料最大值


                    // lineBarsData 屬性定義了要繪製的折線數據
                    lineBarsData: [
                      // 在這裡，只有一個 LineChartBarData，它使用 widget.data 中的數據點來繪製折線
                      LineChartBarData(
                        //  spots 是一個 FlSpot 列表，表示折線上的各個數據點
                        // widget.data => _data
                        spots: _data,  // 將 _data 列表的順序顛倒，然後轉換為 List, .reversed.toList()
                        // spots: _data,
                        isCurved: false,  // 是否使用曲線來連接折線上的數據點
                        colors: [Colors.pinkAccent],  // 折線的顏色
                        barWidth: 4,  // 折線的寬度
                        isStrokeCapRound: true,  // 是否將折線的端點設為圓角
                        belowBarData: BarAreaData(show: true,
                          colors: [Colors.pinkAccent.withOpacity(0.2)]  // 填充區域的顏色，可以使用 Colors 類的顏色，並使用 withOpacity() 方法調整透明度
                        ),  // 折線下區域，是否要填滿

                        // 這些屬性可以控制折線下方的填充區域以及數據點的顯示
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

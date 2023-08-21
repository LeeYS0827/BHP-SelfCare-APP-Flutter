import 'package:flutter/material.dart';

// 定義了一個名為 DateRangePickerWidget 的 Flutter widget，它是一個有狀態的(StatefulWidget)元件
// 使用者可以提供一個回調函式，當他們選擇了日期範圍時，這個回調函式將被呼叫，並且回傳所選擇的起始日期和結束日期
// 整個 widget 的實際外觀和行為將在 _DateRangePickerWidgetState 中實現。
class DateRangePickerWidget extends StatefulWidget {  // 一個自定義的 StatefulWidget
  // 它表示了一個可以被建立和管理狀態的 widget

  // 這是一個參數，它是一個回調函式（Callback Function），用於通知使用者選擇了日期範圍
  final Function(DateTime? startDate, DateTime? endDate) onDateRangeSelected;
  // onDateRangeSelected 是一個函式，它接受兩個 DateTime 型別的參數
  // 分別是選擇的起始日期和結束日期。這個函式將在使用者選擇日期範圍後被調用
  // 【語法說明】
  // 這個語法使用了 Dart 語言的函式型別（Function Type）來定義一個名為 onDateRangeSelected 的變數
  // 這個變數是一個函式型別，可以接受兩個參數：startDate 和 endDate，它們都是 DateTime? 型別
  // 即可以是 DateTime 物件，也可以是 null。

  // 這是一個建構函式(constructor)，它接受一個必要的參數 onDateRangeSelected
  // 用於初始化DateRangePickerWidget 的實例
  // 在建立這個 widget 的實例時，你需要提供一個有效的回調函式(onDateRangeSelected)，用來處理選擇的日期範圍
  // 這個參數的值將被儲存到物件內部的對應成員變數中
  DateRangePickerWidget({required this.onDateRangeSelected});
  // 【語法說明】
  // 這個建構函式的語法是 Dart 語言中的一個特性，允許你在建立一個物件實例時，指定初始值或傳入參數
  // DateRangePickerWidget：這是建構函式的名稱，它與類別的名稱相同，用來建立 DateRangePickerWidget 的實例
  // ({required this.onDateRangeSelected})：這是建構函式的參數列表
  // this.onDateRangeSelected：這部分表示在建立物件實例時
  // 會將提供的 onDateRangeSelected 參數的值賦給類別內的對應成員變數 onDateRangeSelected。這是一種快速將傳入的參數值存儲到類別內部的成員變數的方式

  // 這是覆寫父類的方法，用來建立並返回 _DateRangePickerWidgetState 的實例
  // _DateRangePickerWidgetState 是該 widget 的狀態類別，它將包含實際的 UI 呈現和狀態管理邏輯
  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

// 段程式碼定義了 _DateRangePickerWidgetState 這個狀態類別
// 用來實現 DateRangePickerWidget 的實際外觀和交互邏輯
// 這個狀態類別繼承自 State<DateRangePickerWidget>
// 這意味著它是 DateRangePickerWidget 的狀態管理者，可以存儲和操作與該 widget 相關的狀態
class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  // _startDate 和 _endDate：這兩個成員變數分別存儲選擇的起始日期和結束日期，初值都是 null
  DateTime? _startDate;
  DateTime? _endDate;

  // 這個方法用於處理選擇"開始日期"的動作
  void _pickStartDate() async {
    // 使用 showDatePicker 函式來顯示日期選擇器，讓使用者選擇日期
    final DateTime? date = await showDatePicker(  // date: 即為使用者選的日期
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    // 如果使用者選擇了日期，則將 _startDate 更新為所選的日期
    // 並呼叫 widget.onDateRangeSelected(_startDate, _endDate) 來觸發使用者提供的回調函式
    if (date != null) {
      // 【語法說明】
      // setState() 呼叫位於 _pickStartDate() 和 _pickEndDate() 方法內部
      // 當 _startDate 或 _endDate 更新時，這些方法(_pickStartDate() 和 _pickEndDate())被呼叫
      // 並且在每次 setState() 被呼叫時，Flutter 框架將會重新執行 build() 方法來重新繪製 widget 的 UI
      // 即自動重新繪製以顯示最新的日期
      setState(() {
        _startDate = date;
      });
      widget.onDateRangeSelected(_startDate, _endDate);  // 注意: 應該結束日期選好，才重新畫折線圖
    }
  }
  // 【語法說明】
  // 每當 _startDate 或 _endDate 的值發生變化且這兩個 setState() 被呼叫時
  // Flutter 將自動重新繪製 DateRangePickerWidget 的 UI，這就是「自動重新繪製」的過程
  // 這使得你的 UI 可以根據最新的 _startDate 和 _endDate 值來更新顯示，而不需要手動干預重新繪製的過程

  // 這個方法用於處理選擇"結束日期"的動作
  void _pickEndDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    if (date != null) {
      setState(() {
        _endDate = date;
      });
      widget.onDateRangeSelected(_startDate, _endDate);
    }
  }

  // 這個方法用於建構這個 widget 的 UI
  @override
  Widget build(BuildContext context) {
    // 它包含了兩個按鈕，一個用於選擇開始日期，另一個用於選擇結束日期
    // 在按鈕下方，還有兩個文字顯示目前選擇的開始日期和結束日期
    // 每當 _startDate 或 _endDate 更新時，這個 UI 將自動重新繪製以顯示最新的日期
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(  // 這邊應該要回傳個東西，才能去更新折線圖的日期 (像練習時用到的輸入框，輸入後能進資料庫搜尋，同理這邊輸入後，應該可以傳到圖表來篩選範圍)
              onPressed: _pickStartDate,
              child: Text("選擇開始日期"),
            ),
            ElevatedButton(
              onPressed: _pickEndDate,
              child: Text("選擇結束日期"),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  "開始日期: ${_startDate?.toLocal().toString().split(' ')[0] ?? '未選擇'}"),
              Text(
                  "結束日期: ${_endDate?.toLocal().toString().split(' ')[0] ?? '未選擇'}"),
            ])
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  //CalendarPageクラスの作成し、StatefulWidgetクラスを継承した！
  final DateTime selectedDay; // 選択された日付を受け取るためのパラメータ
  const CalendarPage({Key? key, required this.selectedDay})
      : super(key: key); //親クラスのコンストラクタを呼び出しつつ、必須パラメータであるselectedDayを初期化します

  @override
  State<CalendarPage> createState() => _CalendarPageState();
  //_CalendarPageStateという名前の状態クラスがCalendarPageウィジェットに関連付けられる。CalendarPageウィジェットの状態を管理する。
}





class _CalendarPageState extends State<CalendarPage> {
  //_CalendarPageStateクラスを作成し、State<CalendarPage>クラスを継承する。
  DateTime _focusedDay = DateTime.now(); //現在の日付と時刻を取得し、それを_focusedDayという変数に代入する
  CalendarFormat _calendarFormat =
      CalendarFormat.month; // 初期表示ではカレンダーウィジェットが月表示モードで表示される
  DateTime? _selectedDay; // _selectedDay変数はnull値を持つDateTime型の変数として宣言される
  List<String> _selectedEvents = []; //_selectedEvents変数は空のリストとして初期化されます。

  //Map形式(キーとデータをセットで保存)で保持　keyが日付　値が文字列
  //utc(協定世界時)
  final sampleMap = {
    DateTime.utc(2024, 2, 20): ['一つ目のイベント', '二つ目のイベント'],//これでイベントを作成
    DateTime.utc(2024, 2, 5): ['3つ目のイベント', '4つ目のイベント'],
  };

  final sampleEvents = {
    DateTime.utc(2024, 2, 20): ['first', 'secondEvent'],
    DateTime.utc(2024, 2, 5): ['thirdEvent', 'fourthEvent']
  };

  @override
  //initStateメソッドは、ウィジェットの状態が最初に作成されたときに一度だけ呼び出されます。
  void initState() {
    super.initState();
    _focusedDay = widget.selectedDay;
    _selectedDay = widget.selectedDay;
    _selectedEvents = sampleEvents[widget.selectedDay] ?? [];
    debugPrint("確認");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // カレンダーUI実装
      body: Column(
        children: [
          Padding(//余白を作るためのwidget
            padding: const EdgeInsets.all(20.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,//現在見ているデータ
              eventLoader: (date) {
                // イベントドット処理
                return sampleMap[date] ?? [];
              },
              calendarFormat: _calendarFormat, // デフォを月表示に設定
              onFormatChanged: (format) {
                // 「月」「週」変更
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              // 選択日のアニメーション
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              // 日付が選択されたときの処理
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents = sampleEvents[selectedDay] ?? [];
                });
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) {
                  return Container(
                    margin: const EdgeInsets.all(4.0), //余白を与える
                    alignment: Alignment.center, //真ん中に配置する
                    decoration: BoxDecoration(
                      //Contaner などの見た目を整えるプロパティ
                      color: Colors.deepPurple,
                      borderRadius:
                          BorderRadius.circular(10.0), //全ての角を指定された半径で丸めます
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          '${date.day}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const Positioned(
                          right: -6,
                          bottom: -5,
                          child: Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 60, 255, 6),
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // タップした時表示するリスト
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return Card(
                  child: ListTile(
                    title: Text(event),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.startDocked, //floatingActionButtonを左に寄せる
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50.50), //余白を作成
        child: FloatingActionButton.extended(
          backgroundColor: const Color.fromARGB(255, 222, 181, 255),
          onPressed: () {
            Navigator.pop(context); //前の画面に戻る
          },
          label: const Text('戻る'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}

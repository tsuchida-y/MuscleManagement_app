import 'package:flutter/material.dart';
import 'package:flutter_application_1/calendar_page.dart';

void main() {
  runApp(const MyApp()); //constで宣言した変数は変えることができない
}
//StatelessWidget：再描画が必要でない時に使う
//静的なテキスト、アイコン、画像など、変化しないUI要素に使われます。
//buildメソッドは必須メソッド
class MyApp extends StatelessWidget {
  const MyApp({super.key});//MyAppのコンストラクタ
  @override//サブクラスでスーパークラスのメソッドと同じ名前、引数、戻り値を持つメソッドを再定義（オーバーライド）することができます
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        //ウィジェットツリーの全体的なビジュアルテーマをカスタマイズするためのクラス。
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), //作成したパレットからいい感じにしてくれる
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MuscleManagement'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  //Stateは状態が変わった場合に再描画
  //StatefulWidget では、この createState() メソッドを使って対応する State クラスのインスタンスを作成し、ウィジェットに紐づける
  //_をつけることでプライベートクラスになる
  //=>はアロー関数（createState メソッドが _MyHomePageState インスタンスを返していることを表しています。）
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  DateTime now = DateTime.now();//現在の日時を取得

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,//背景の設定
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,//真ん中に配置する
          children: <Widget>[
            const Text(
              '　できた！',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Stack(
        //ボタンを複数使用するときに使う
        //複数の子ウィジェットを重ねて表示する
        children: <Widget>[
          Align(
            alignment: const Alignment(0.1, 0.4), //ボタンの位置を座標で決める
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CalendarPage(selectedDay: now), //現在の時間を渡す
                  ),
                );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
          Align(
            alignment: const Alignment(0.15, 0.6),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.deepPurple),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalendarPage(selectedDay: now),
                    ));
              },
              child: const Text('カレンダー'),
            ),
          ),
        ],
      ),
    );
  }
}

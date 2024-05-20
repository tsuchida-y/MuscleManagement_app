import 'package:flutter/material.dart';
import 'package:flutter_application_1/calendar_page.dart';

void main() {
  runApp(const MyApp()); //constで宣言した変数は変えることができない
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        //ウィジェットツリーの全体的なビジュアルテーマをカスタマイズするためのクラス。
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), //作成したパレットからいい感じにしてくれる
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Muscle training'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  DateTime now = DateTime.now();
  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'あなたがボタンを押した回数:',
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
              onPressed: _incrementCounter,
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
                        builder: (context) => const CalendarPage()));
              },
              child: const Text('カレンダー'),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:whatHome/page/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:whatHome/page/home_page.dart';
import 'package:whatHome/provider/feedback_position_provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => FeedbackPositionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('increment_floatingActionButton'),
          onPressed: () => context.read<Counter>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}





class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _email = "";
  String _password = "";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () async {
              Map<String, dynamic> data = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              setState(() {
                _email = data["email"];
                _password = data["password"];
              });
            },
            icon: const Icon(Icons.login, size: 18),
            label: const Text("login page"),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
            icon: const Icon(Icons.swipe, size: 18),
            label: const Text("Home swiping page"),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => blankPage(),
              ),
            ),
            icon: const Icon(Icons.check_box_outline_blank, size: 18),
            label: const Text("Blank page"),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => blankPage(),
              ),
            ),
            icon: const Icon(Icons.ramen_dining, size: 18),
            label: const Text("Blank page"),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => blankPage(),
              ),
            ),
            icon: const Icon(Icons.chat_bubble, size: 18),
            label: const Text("Blank page"),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => blankPage(),
              ),
            ),
            icon: const Icon(Icons.business_center, size: 18),
            label: const Text("Blank page"),
          ),
          Text(_email),
          Text(_password),
          Count(),
        ],
      ),
    );
  }
}

class blankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Blank page'
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, _) {
        return Text('${counter.count}',
            key: const Key('counterState'),
            style: Theme.of(context).textTheme.headline4);
      },
    );
  }
}

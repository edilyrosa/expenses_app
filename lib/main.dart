import 'package:expenses_app/widgets/user_transaccions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter App 2"),
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start, //!Default .start
            crossAxisAlignment:
                CrossAxisAlignment.stretch, //! = double.infinity
            children: <Widget>[
              Container(
                width: 400, //!No esta cogiendo el ancho de tu padre.
                child: const Card(
                    color: Color.fromARGB(255, 217, 104, 192),
                    child: Text("CHART")),
              ),
              const UserTransactions(),
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

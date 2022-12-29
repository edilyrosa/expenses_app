import 'dart:js_util';

import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

//?trabajar sobre este
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Color.fromARGB(255, 171, 50, 125),
          fontFamily: "Quicksand", //!font general
          textTheme: ThemeData.light().textTheme.copyWith(
              //!se lo podremos aplicar a acualqueir texto q lo invoque
              headline6: const TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: "OpenSans",
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//!class 2 of stateful: extends State has the void method with setState() & build()
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New shoes', amount: 20.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Grociers',
    //     amount: 50.99,
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'New t-shirt', amount: 10.99, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
    //debimos convertir _userTransactions a list, con .toList()
    //pq where() return un Iterable<transaction> no una lista, y ese es el TDD getter
    //asi q lo q resulte de where() debe ser convertido a List
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        //!Final xq se crea con valores que son pasados dentro de este metodo
        //!o sea creado con valores que desconozco al momento de escribir el codigo
        //!por eso, "const" no puede ser usado aqui, pq NO SE EL VALOR PARA PONERCELO YA
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //!Method to open a modal sheet, there a native method to do it. but in the order to not repeat
    //!We'll do it a general method, to use it when we want to trigger.
    //!Show the sheet of field's area through showModalBottomSheet()
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        //Must return a widget which must be inside the modal sheet}
        return GestureDetector(
          //Must wrap the modal wigget on this, for register a gesture like onTap
          onTap:
              () {}, //evento al toque, no hacer nada cuando se toque el widget modal.
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expenses"), //Affected by AppBarTheme()
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(
              Icons.add,
              color: Colors.pink,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start, //!Default .start
          crossAxisAlignment: CrossAxisAlignment.stretch, //! = double.infinity
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions) //!PINTA LA LISTA
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(
          Icons.add,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

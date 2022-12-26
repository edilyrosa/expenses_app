import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  //!class 1 stateful
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  //!class 2 of stateful
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New shoes', amount: 20.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Grociers',
        amount: 50.99,
        date: DateTime.now()),
    Transaction(
        id: 't3', title: 'New t-shirt', amount: 10.99, date: DateTime.now())
  ];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}

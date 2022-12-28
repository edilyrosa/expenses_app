import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, //!Viewpor's height of next column scrollable
      child: ListView.builder(
        itemBuilder: (context, index) {
          //!Index will give access to every child.
          return Card(
              //!Must return the widget item which will form the column scrollable
              child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColorLight, width: 2)),
                padding: const EdgeInsets.all(10),
                child: Text(
                  '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(DateFormat.yMMMd()
                      .add_jm()
                      .format(transactions[index].date)),
                ],
              )
            ],
          ));
        },
        itemCount: transactions
            .length, //!Just number of items. Because it will repeat the itemBuilder: funcion for every item.
      ),
    );
  }
}

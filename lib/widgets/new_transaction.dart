import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 226, 208, 224),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        //width: 400, //!No lo toma, el height si
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              cursorColor: const Color.fromARGB(255, 228, 14, 228),
              decoration: const InputDecoration(labelText: "Title:"),
              controller: titleController,
            ),
            TextField(
              cursorColor: const Color.fromARGB(255, 228, 14, 228),
              decoration: const InputDecoration(labelText: "Amount:"),
              controller: amountController,
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            TextButton(
              child: const Text('Add transaction'),
              //style: ButtonStyle(),
              onPressed: () {
                addTx(
                    titleController.text, double.parse(amountController.text));
              },
            )
          ],
        ),
      ),
    );
  }
}

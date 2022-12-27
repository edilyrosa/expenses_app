import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTx;
  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      //!VALIDATION
      return; //!Stop function's execution.
    }
    addTx(enteredTitle, enteredAmount);
  }

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
              onSubmitted: (_) => submitData(),
              controller: titleController,
            ),
            TextField(
              cursorColor: const Color.fromARGB(255, 228, 14, 228),
              decoration: const InputDecoration(labelText: "Amount:"),
              keyboardType: TextInputType.number,
              //! for iOS: keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
              controller: amountController,
              // onChanged: (value) {
              //   amountInput = value;
              // },
            ),
            TextButton(
                onPressed: submitData, child: const Text('Add transaction'))
          ],
        ),
      ),
    );
  }
}

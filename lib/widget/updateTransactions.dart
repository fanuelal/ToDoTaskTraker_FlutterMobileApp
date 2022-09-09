import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateTransaction extends StatefulWidget {
  final Function updateHandler;

  UpdateTransaction(this.updateHandler);

  @override
  State<UpdateTransaction> createState() => _UpdateTransactionState();
}

class _UpdateTransactionState extends State<UpdateTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;
  
  void submitHander() {
    if (amountController.text.isEmpty) {
      return;
    }
    final String inputTitle = titleController.text;
    final double inputAmount = double.parse(amountController.text);

    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.updateHandler(inputTitle, inputAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2099))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      elevation: 5,
      child: Container(
       width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(6),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Edit Task Name'),
              controller: titleController,
              onSubmitted: (_) => submitHander(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Update Needed Time'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitHander(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[  
                  Text(_selectedDate == null
                      ? 'No Date Picked'
                      : DateFormat.yMd().format(_selectedDate), ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: RaisedButton(            
                        color: Theme.of(context).primaryColor,
                        // textColor: Theme.of(context).textTheme.button.color,
                        onPressed: _displayDatePicker,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text('Update Task'),
              onPressed: submitHander,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './updateTransactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteHandler;
  TransactionList(this.transactions, this.deleteHandler);
  void _UpdateTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: UpdateTransaction(_updateTransactionItem),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _updateTransactionItem(int index) {
    // transactions[index].title = '';
    // setState(() {
    //   transactions.add(newtx);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'Empty Transaction',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/emptyTask.png',
                    fit: BoxFit.cover,
                  ))
            ],
          )
        : Container(
            height: 450,
            child: ListView.builder(
              itemBuilder: (cnxt, index) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    color: Colors.green,
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    padding: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    color: Colors.red,
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('${transactions[index].amount} M'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          deleteHandler(transactions[index].id);
                        },
                      ),
                      onTap: () {
                        _UpdateTransaction;
                      },
                    ),
                  ),
                  onDismissed: (DismissDirection direction) {
                    // deleteHandler(transactions[index].id
                    if (direction == DismissDirection.endToStart) {
                      deleteHandler(transactions[index].id);
                    }

                    String action = direction == DismissDirection.startToEnd
                        ? "Done!"
                        : "Deleted!";
                    Color conditionalColor =
                        direction == DismissDirection.startToEnd
                            ? Colors.green
                            : Colors.red;

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: conditionalColor,
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Task $action",
                          style: TextStyle(
                              fontFamily: 'TitilliumWeb',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        // action: SnackBarAction(label: "Undo", onPressed: null),
                      ),
                    );
                  },
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}

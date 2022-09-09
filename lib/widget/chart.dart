import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(
      7,
      (index) {
        final weekly = DateTime.now().add(Duration(days: index));
        var totalAmount = 0.0;
        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekly.day &&
              recentTransactions[i].date.month == weekly.month &&
              recentTransactions[i].date.year == weekly.year) {
            totalAmount += recentTransactions[i].amount;
          }
        }
        return {
          'day': DateFormat.E().format(weekly).substring(0, 2),
          'amount': totalAmount
        };
      },
    ).toList();
  }

  double get _totalSpending {
    return groupedTransactionValue.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data) {
          return Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ChartBar(
              data['day'],
              data['amount'],
              _totalSpending == 0.0 ? 0.0 : (data['amount'] as double)  / _totalSpending
            ),
          );
        }).toList()),
      ),
    );
  }
}

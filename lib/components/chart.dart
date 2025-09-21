import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double sumTransactionsForDay(
        List<Transaction> transactions,
        DateTime day,
      ) {
        return transactions
            .where(
              (tr) =>
                  tr.date.day == day.day &&
                  tr.date.month == day.month &&
                  tr.date.year == day.year,
            )
            .fold(0.0, (sum, tr) => sum + tr.value);
      }

      double totalSum = sumTransactionsForDay(recentTransactions, weekDay);

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: groupedTransactions.map((tr) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(tr['day'].toString(), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text(
                  'R\$ ${tr['value'].toString()}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

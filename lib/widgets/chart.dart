import 'package:expenses_app/models/transactions.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, 
    required this.recentTransactions, 
    required this.categoryColor
    }) : super(key: key);

  final List<Transactions> recentTransactions;
  final Color categoryColor;

  Color getCategoryColor(String title) {
    if (title == 'Paliwo') {
      return Colors.red;
    } else if (title == 'Zakupy') {
      return Colors.green;
    } else if (title == 'Jedzenie') {
      return Colors.blue;
    } else {
      return Colors.purple;
    }
  }

  List<Map<String, dynamic>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
              totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3), 
        'amount': totalSum
        };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'] ; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        elevation: 8,
        margin: const EdgeInsets.all(4),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: 
              groupedTransactionsValues.map((data){
                return ChartBar(
                  categoryColor: categoryColor,
                  label: data['day'] as String, 
                  spendingAmount: data['amount'] as double, 
                  spendingPercentage: totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending
                  );
              }).toList()
            ,
          ),
        ),
      ),
    );
  }
}
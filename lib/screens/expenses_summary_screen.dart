import 'package:expenses_app/screens/expense_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/models/transactions.dart';
import 'package:intl/intl.dart';


class ExpensesSummaryScreen extends StatelessWidget {
  final List<Transactions> transactions;

  const ExpensesSummaryScreen(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> monthlyExpenses = {};

    for (final transaction in transactions) {
      final monthYear = DateFormat.yMMMM().format(transaction.date);
      if (monthlyExpenses.containsKey(monthYear)) {
        monthlyExpenses[monthYear] += transaction.amount;
      } else {
        monthlyExpenses[monthYear] = transaction.amount;
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your monthly Expenses',
          style: TextStyle(
            fontSize: 16
          )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: monthlyExpenses.length,
              itemBuilder: (context, index) {
                final monthYear = monthlyExpenses.keys.elementAt(index);
                final totalAmount = monthlyExpenses[monthYear]!;

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                    final formattedDate = DateFormat.yMMMM().parse(monthYear);
                    final selectedMonth = DateTime(formattedDate.year, formattedDate.month);
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => 
                          ExpenseHistoryScreen(transactions, selectedMonth:selectedMonth )));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: const Icon(Icons.credit_card_sharp,
                      color: Colors.white
                      ),
                    ),
                    title: Text(monthYear),
                    subtitle: Text(
                      'Total spent: ${totalAmount.toStringAsFixed(2)} zł',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

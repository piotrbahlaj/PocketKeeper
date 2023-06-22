import 'package:flutter/material.dart';
import 'package:expenses_app/models/transactions.dart';
import 'package:intl/intl.dart';

class ExpenseHistoryScreen extends StatelessWidget {
  final List<Transactions> transactions;
  final DateTime selectedMonth;

  const ExpenseHistoryScreen(
    this.transactions, 
    {Key? key, 
    required this.selectedMonth
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedMonth = DateFormat('MMMM yyyy').format(selectedMonth);
    final filteredTransactions = transactions.where((transaction) {
      return transaction.date.month == selectedMonth.month &&
          transaction.date.year == selectedMonth.year;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense History - $formattedMonth' ,
          style: const TextStyle(fontSize: 13),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredTransactions.length,
        itemBuilder: (context, index) {
          final transaction = filteredTransactions[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.monetization_on_sharp,
                color: Colors.white
              ),
            ),
            title: Text(transaction.title),
            subtitle: Text(
              'Amount: ${transaction.amount} zł\nDate: ${DateFormat.yMd().format(transaction.date)}',
            ),
          );
        },
      ),
    );
  }
}

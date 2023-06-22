import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key, 
    required this.transactions, 
    required this.deleteTransaction
    }) : super(key: key);
  
  final List<Transactions> transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? 
      LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(height: 10),
          Text(
            'No transactions added to the list',
          style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox( 
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover
              ),
          )
         ],
        );
       },
      ) : 
      ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8, 
              horizontal: 5
              ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FittedBox(
                      child: Text('${transactions[index].amount}zł',
                        style: const TextStyle(
                          color: Colors.white
                       ),
                      ),
                    ),
                  ),
              ),
              title: Text(
                transactions[index].title, style: Theme.of(context).textTheme.headline1
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date)
                  ),
                  trailing: MediaQuery.of(context).size.width > 360 ? 
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).errorColor),
                    icon: const Icon(Icons.delete) ,
                    label: const Text('Delete'),
                    onPressed: () => deleteTransaction(transactions[index].id),
                    ) : 
                    IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor
                      ), 
                    onPressed: () => deleteTransaction(transactions[index].id)
                    ),
            ),
          );
        },
        itemCount: transactions.length,
      );
  }
}
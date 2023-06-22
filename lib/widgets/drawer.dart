import 'package:expenses_app/models/transactions.dart';
import 'package:expenses_app/screens/expenses_summary_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final List<Transactions> transactions;
  const MainDrawer({Key? key, required this.transactions}) : super(key: key);

  Widget buildListTile (String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
            leading: Icon(
              icon, 
              size: 40
            ),
            title: Text(
              title, 
              style: const TextStyle(
                fontFamily: 'OpenSans-Regular',
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            ),
            onTap: tapHandler,
          );
    }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: const Text(
              'PocketKeeper',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Colors.red
              )
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
            'Expenses summary', 
            Icons.monetization_on,
            () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ExpensesSummaryScreen(transactions))
              );
            }
          ),
        ]
      ),
    );
  }
}
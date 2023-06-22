import 'package:expenses_app/models/transactions.dart';
import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/drawer.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
    ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PocketKeeper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple)
          .copyWith(
            secondary: Colors.amber),
            fontFamily: 'Quicksand',
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Quicksand', 
                  fontSize: 15,
                  fontWeight: FontWeight.normal
              ),
              bodyText2: TextStyle(
                fontFamily: 'OpenSans', 
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey
              ),
              headline1: TextStyle(
                fontFamily: 'Quicksand', 
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
              headline6: TextStyle(
                fontFamily: 'Quicksand', 
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )
            )
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transactions> _userTransactions = [];
  Color _chartCategoryColor = Colors.purple;
  
  bool _showChart = false;

  List<Transactions> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7)
        )
      );
    }).toList();
  }

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

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate, 
      id: DateTime.now().toString(),
      color: getCategoryColor(txTitle)
      );

      setState(() {
        _userTransactions.add(newTx);
      });
  }
  
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx, 
      builder: (_) {
        return GestureDetector(
          onTap: (){},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            addTx: _addNewTransaction
            ),
          );
      } 
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere(
        (tx) => tx.id == id
        );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
        title: Text(
          'PocketKeeper',
        style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: (){
              _startAddNewTransaction(context);
            }, 
            icon: const Icon(
              Icons.add
              )
            )
        ],
      );
      final txListWidget = SizedBox(
              height: (mediaQuery.size.height - 
              appBar.preferredSize.height - 
              mediaQuery.padding.top) 
              * 0.7,
              child: TransactionList(
                transactions: _userTransactions, 
                deleteTransaction: _deleteTransaction,
                ),
            );
            final pageBody = SafeArea(
              child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart',
                style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: _showChart,
                  onChanged: (value) {
                  setState(() {
                  _showChart = value;
                  });
                 },
                ),
              ],
            ),
            if (!isLandscape) SizedBox(
              height: (mediaQuery.size.height - 
              appBar.preferredSize.height - 
              mediaQuery.padding.top) 
              * 0.3,
              child: Chart(
                categoryColor: _chartCategoryColor,
                recentTransactions: _recentTransactions
                ),
            ),
            if (!isLandscape) txListWidget,
            if (isLandscape) _showChart 
            ? SizedBox(
              height: (mediaQuery.size.height - 
              appBar.preferredSize.height - 
              mediaQuery.padding.top) 
              * 0.3,
              child: Chart(
                categoryColor: _chartCategoryColor,
                recentTransactions: _recentTransactions
                ),
            ) 
            : txListWidget
         ],
        ),
       )
      );
    return Scaffold(
      drawer: MainDrawer(transactions: _userTransactions,),
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _startAddNewTransaction(context);
        },
        child: const Icon(
          Icons.add
          ),
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widget/chart.dart';
import './widget/newTransaction.dart';
import './models/transaction.dart';
import './widget/transactionList.dart';
import './widget/splashScreen.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      home: SplashScreen(),
      // darkTheme: ThemeData.dark().copyWith(
      //   // primaryColor: Colors.black45,
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

ThemeData _dark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.amber,
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
  ),
  cardTheme: CardTheme(color: Colors.black),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        fontFamily: 'TitilliumWeb', fontSize: 20, fontWeight: FontWeight.bold),
  ),
);

ThemeData _light = ThemeData(
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.amber,
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black45,
        fontFamily: 'TitilliumWeb',
        fontSize: 20,
        fontWeight: FontWeight.bold),
  ),
  cardTheme: CardTheme(color: Colors.white),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        fontFamily: 'TitilliumWeb', fontSize: 20, fontWeight: FontWeight.bold),
  ),
);

bool isDark = false;

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(
    //     id: 't1', title: 'new shose', amount: 100.78, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'new clothes', amount: 30.78, date: DateTime.now()),
    // Transaction(id: 't3', title: 'food', amount: 98.78, date: DateTime.now()),
  ];
  List<Transaction> get _recentTransaction {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime pickedDate) {
    Transaction newtx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: pickedDate,
    );
    setState(() {
      transactions.add(newtx);
    });
  }

  void _displayTransactionAdd(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactionList(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  // var isDark = false;
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      centerTitle: true,
      leading: Container(
        padding: EdgeInsets.all(8),
        child: Image.asset('assets/images/logo.png'),
      ),
      title: Text('TO DO'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sunny),
          onPressed: () {
            if (isDark) {
              setState(() {
                isDark = false;
              });
            } else {
              setState(() {
                isDark = true;
              });
            }
          },
        ),
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? _dark : _light,
      home: Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.30,
                  child: Chart(_recentTransaction)),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.70,
                  child: TransactionList(transactions, _deleteTransaction)),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () => _displayTransactionAdd(context),
            child: Icon(Icons.add)),
      ),
    );
  }
}

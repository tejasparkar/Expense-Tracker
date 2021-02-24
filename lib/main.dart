import 'package:expensesapp/widgets/add_transaction.dart';
import 'package:expensesapp/widgets/chart.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import './model/transaction.dart';
import './widgets/chart.dart';

void main(){
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
      home : HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
 
  // String titleinput;
  // String amountinput;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


   final List<Transaction> _userTransactionList = [
      Transaction(
      id: 't1', 
      title: 'New Shoes',
      amount: 99.99 , 
      date: DateTime.now() ),
      Transaction(
      id: 't2', 
      title: 'Weekly Groceries',
      amount: 16.99 , 
      date: DateTime.now() ),
      Transaction(
      id: 't3', 
      title: 'Buy Milk',
      amount: 48.99 , 
      date: DateTime.now() ),
  ];

  List<Transaction> get _recentTransactions {

    return _userTransactionList.where((tx){
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7)));
    }).toList(); 
  }
 

  void _addNewTransaction(String txTitle, double txAmount , DateTime chosenDate){
    final newTx = Transaction(title:txTitle , amount: txAmount , date: chosenDate , id: DateTime.now().toString() );
    setState((){
      _userTransactionList.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
    context: ctx,
    builder: (_){
      return GestureDetector(
        onTap:(){},
        behavior: HitTestBehavior.opaque,
        child: NewTransaction(_addNewTransaction));
    });
  }
  void _deleteTransaction(String id){
      setState(() {
        _userTransactionList.removeWhere((tx) => tx.id == id );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar : AppBar(
      title: Text('Personal Expenses',
      style: TextStyle(
        fontWeight : FontWeight.bold
      ),),
       actions: <Widget>[
         IconButton(icon:Icon(Icons.add) ,
          onPressed: ()=>_startAddNewTransaction(context))
       ],
     ),
     body: SingleChildScrollView(
            child: Column(
         
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children :<Widget>[
          Chart(_recentTransactions),
          TransactionList(_userTransactionList , _deleteTransaction)
         ]
       ),
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton : FloatingActionButton(
       onPressed: ()=>_startAddNewTransaction(context),child: Icon(Icons.add),)
    );
    
  }
}
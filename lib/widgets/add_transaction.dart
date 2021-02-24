import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;


  void submitData(){
    if(_amountController.text.isEmpty)
    {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
     if(enteredTitle.isEmpty || enteredAmount <=0 || _selectedDate == null){
       return;
     }
     
     widget.addTx(
      enteredTitle ,
      enteredAmount ,
      _selectedDate
         );

       Navigator.of(context).pop();
  }

  void _showDatePicker(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(),
        firstDate: DateTime(2019),
         lastDate: DateTime.now()).then((pickedDate)  {
           if(pickedDate == null){
             return;
           }
         setState(() {
            _selectedDate = pickedDate;
         });
         });
  }

  @override
  Widget build(BuildContext context) {
    return   Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(decoration: InputDecoration(labelText: "Title"),
                onSubmitted: (_)=> submitData(),
                controller: _titleController,
                // onChanged: (val){
                //   titleinput = val;
                // },
                ),
                TextField(decoration: InputDecoration(labelText:"Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_)=> submitData(),
                // onChanged: (val){
                //   amountinput = val;
                // },
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(_selectedDate == null ? 'No Date Chosen' : 'Picked Date : ${DateFormat.yMd().format(_selectedDate)}')),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: _showDatePicker, child: Text('Choose Date',style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),))
                    ],
                  ),
                ),
                RaisedButton(
                onPressed: submitData, 
                child: Text("Add Transaction"),
                color:Theme.of(context).primaryColor,
                textColor: Colors.white,)
              ],
            ),
          ),
        );
  }
}
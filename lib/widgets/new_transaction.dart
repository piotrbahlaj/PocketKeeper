import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({
    Key? key, 
    required this.addTx
    }) : super(key: key);
  
  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );          

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
        _selectedDate = pickedDate;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 10, 
                  left: 10, 
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                  right: 10
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     TextField(
                      decoration: const InputDecoration(
                        labelText: 'Title'
                      ),
                      controller: _titleController,
                      onSubmitted: (_) => _submitData(),
                    ),
                     TextField(
                      decoration: const InputDecoration(
                        labelText: 'Amount'
                      ),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => _submitData(),
                     ),
                     SizedBox(
                      height: 70,
                       child: Row(
                        children: [
                           Expanded(
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                _selectedDate == null 
                                ? 'No date chosen' 
                                :'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
                                style:Theme.of(context).textTheme.bodyText2
                            ),
                             ),
                           ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.primary
                              ),
                              onPressed: _presentDatePicker, 
                              child: const Text(
                                'Choose a date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                                )
                              ),
                          )
                        ],
                       ),
                     ),
                     ElevatedButton(
                      onPressed: _submitData,
                      child:const Text(
                        'Add transaction',
                      style: TextStyle(
                        fontWeight: FontWeight.normal
                        ),
                       ),
                      )
                    ],
                  ),
                ),
             ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:daily_expenditure_tracker/components/expense_tile.dart';
import 'package:daily_expenditure_tracker/components/summary.dart';
import 'package:daily_expenditure_tracker/data/expense_data.dart';
import 'package:daily_expenditure_tracker/datetime/datetime_helper.dart';
import 'package:daily_expenditure_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void save() {
    ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: newExpenseAmountController.text,
        dateTime: DateTime.now());
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addnewexpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Enter Expense",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.amber,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newExpenseNameController,
                    decoration: InputDecoration(
                        hintText: 'Name of the Expense',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: newExpenseAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.white60)),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              actions: [
                // save button
                MaterialButton(
                  onPressed: save,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                // cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    // ExpenseItem newExpense = ExpenseItem(
    //     name: "Bills",
    //     amount: "20",
    //     dateTime: DateTime.now().subtract(Duration(days: 1)));
    // Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: Colors.amber[200],
            floatingActionButton: FloatingActionButton(
              onPressed: addnewexpense,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.amber,
            ),
            body: ListView(
              children: [
                Summary(startOfWeek: value.startOfWeekDate()),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) => ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value.getAllExpenseList()[index].amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                        deleteTapped: (p0) => {
                          deleteExpense(value.getAllExpenseList()[index]),
                        },
                        )),
              ],
            )));
  }
}

import 'package:daily_expenditure_tracker/models/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  final _mybox = Hive.box("expense_database");

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _mybox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _mybox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dt = savedExpenses[i][2];

      ExpenseItem expenseItem =
          ExpenseItem(name: name, amount: amount, dateTime: dt);

      allExpenses.add(expenseItem);
    }
    return allExpenses;
  }
}

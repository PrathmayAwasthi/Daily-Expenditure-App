import 'package:daily_expenditure_tracker/components/bar%20graph/bar_graph.dart';
import 'package:daily_expenditure_tracker/data/expense_data.dart';
import 'package:daily_expenditure_tracker/datetime/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Summary extends StatelessWidget {
  final DateTime startOfWeek;

  const Summary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    double calcMax(
        ExpenseData value,
        String monday,
        String tuesday,
        String wednesday,
        String thursday,
        String friday,
        String saturday,
        String sunday) {
      double? max = 100;
      List<double> values = [
        value.calculateDailyExpenseSummary()[monday] ?? 0,
        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
        value.calculateDailyExpenseSummary()[thursday] ?? 0,
        value.calculateDailyExpenseSummary()[friday] ?? 0,
        value.calculateDailyExpenseSummary()[saturday] ?? 0,
        value.calculateDailyExpenseSummary()[sunday] ?? 0,
      ];
      values.sort();
      max = values.last * 1.1;
      // Debug this
      return 100;
    }

    double calcTotal(
        ExpenseData value,
        String monday,
        String tuesday,
        String wednesday,
        String thursday,
        String friday,
        String saturday,
        String sunday) {
      double total = 0;
      List<double> values = [
        value.calculateDailyExpenseSummary()[monday] ?? 0,
        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
        value.calculateDailyExpenseSummary()[thursday] ?? 0,
        value.calculateDailyExpenseSummary()[friday] ?? 0,
        value.calculateDailyExpenseSummary()[saturday] ?? 0,
        value.calculateDailyExpenseSummary()[sunday] ?? 0,
      ];
      for (int i = 0; i < values.length; i++) {
        total = total + values[i];
      }
      return total;
    }

    String monday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateTimeObjectToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Total Expenditure: ₹" +
                  calcTotal(value, monday, tuesday, wednesday, thursday, friday,
                          saturday, sunday)
                      .toString(),
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: calcMax(value, monday, tuesday, wednesday, thursday, friday,
                  saturday, sunday),
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

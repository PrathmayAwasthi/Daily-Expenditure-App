// ignore_for_file: sort_child_properties_last, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [SlidableAction(onPressed: deleteTapped, icon: Icons.delete, backgroundColor: Colors.red, borderRadius: BorderRadius.circular(5), )],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.5),
        child: Container(
          child: ListTile(
            title: Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              dateTime.day.toString() +
                  "/" +
                  dateTime.month.toString() +
                  "/" +
                  dateTime.year.toString() +
                  " Time: " +
                  dateTime.hour.toString() +
                  ":" +
                  dateTime.minute.toString(),

              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            trailing: Text(
              '\₹' + amount,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}

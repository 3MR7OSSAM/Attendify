import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.date, required this.isExam});
  final DateTime date;
  final bool isExam;
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Card(
        color: isExam ? Colors.deepOrange.shade400 :Colors.blue.shade400,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat.MMMM().format(date), // Display month name
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                 // fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
           //   const SizedBox(height: 8.0),
              Text(
                DateFormat.d().format(date), // Display day number
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            //  const SizedBox(height: 8.0),
              FittedBox(
                child: Text(
                  DateFormat.EEEE().format(date), // Display day name
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
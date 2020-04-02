import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:orcamento/models/object.dart';


import 'ChartBar.dart';

class Chart extends StatelessWidget {

  final List<Object> recenteObject;
  Chart(this.recenteObject);

  List<Map<String, Ob>> get groupedObjectes {
    return List.generate(7, (index){
      final DateTime weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (int i = 0; i < this.recenteObject.length; i++ ){
        bool mDay = this.recenteObject[i].date.day == weekDay.day;
        bool mMonth = this.recenteObject[i].date.month == weekDay.month;
        bool mYear = this.recenteObject[i].date.year == weekDay.year;
        if(mDay && mMonth && mYear)
          totalSum += this.recenteObject[i].value;
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };

    }).reversed.toList();
  }

  double get _weekTotalValue {
    return this.groupedObjectes.fold(0.0,
        (double sum , Map<String, Ob> object) {
      return sum + object['value'];
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this.groupedObjectes.map((object) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: object['day'],
                value: object['value'],
                percentage: this._weekTotalValue != 0
                    ? (object['value'] as double) / this._weekTotalValue
                    : 0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

}
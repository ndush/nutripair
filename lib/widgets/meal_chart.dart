import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MealChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 40,
              title: 'Carbs',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 30,
              title: 'Protein',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 20,
              title: 'Fat',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 10,
              title: 'Fiber',
              radius: 50,
              titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MealBuilder extends StatefulWidget {
  @override
  _MealBuilderState createState() => _MealBuilderState();
}

class _MealBuilderState extends State<MealBuilder> {
  List<String> droppedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visual Meal Builder')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDraggable('Chicken', Colors.blue),
                SizedBox(width: 10),
                buildDraggable('Beef', Colors.red),
                SizedBox(width: 10),
                buildDraggable('Fish', Colors.green),
              ],
            ),
            SizedBox(height: 50), // Space between Draggables and DragTarget
            DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 200,
                  width: 300,
                  color: droppedItems.isEmpty ? Colors.green : Colors.orange,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (droppedItems.isEmpty)
                          Text('Drop Here', style: TextStyle(color: Colors.white))
                        else
                          ...droppedItems.map((item) => Text(item, style: TextStyle(color: Colors.white))).toList(),
                      ],
                    ),
                  ),
                );
              },
              onAccept: (data) {
                setState(() {
                  droppedItems.add(data); // Add the dropped item to the list
                });
                print('Dropped: $data');
              },
              onWillAccept: (data) {
                return data != null; // Allow acceptance of any non-null data
              },
            ),
          ],
        ),
      ),
    );
  }

  Draggable<String> buildDraggable(String item, Color color) {
    return Draggable<String>(
      data: item,
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: color,
        child: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
      ),
      feedback: Material(
        child: Container(
          padding: EdgeInsets.all(16.0),
          color: color,
          child: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey,
        child: Text(
          item,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

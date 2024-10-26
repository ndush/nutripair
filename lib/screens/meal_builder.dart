import 'package:flutter/material.dart';

class MealBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visual Meal Builder')),
      body: Center(
        child: Column(
          children: [
            Draggable<String>(
              data: 'Chicken',
              child: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.blue,
                child: Text('Chicken'),
              ),
              feedback: Material(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.blue,
                  child: Text('Chicken'),
                ),
              ),
              childWhenDragging: Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey,
                child: Text('Chicken'),
              ),
            ),
            DragTarget<String>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                  height: 200,
                  width: 200,
                  color: Colors.green,
                  child: Center(child: Text('Drop Here')),
                );
              },
              onAccept: (data) {
                // Handle meal ingredient drop
                print('Dropped: $data');
              },
            ),
          ],
        ),
      ),
    );
  }
}

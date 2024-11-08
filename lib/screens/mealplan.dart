import 'package:flutter/material.dart';

class MealPlan {
  final String name;

  MealPlan({required this.name});
}

class MealPlanningScreen extends StatefulWidget {
  @override
  _MealPlanningScreenState createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  List<MealPlan> mealPlans = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchMealPlans();
  }

  Future<void> fetchMealPlans() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      await Future.delayed(Duration(seconds: 2));
      mealPlans = [
        MealPlan(name: 'Breakfast Plan'),
        MealPlan(name: 'Lunch Plan'),
        MealPlan(name: 'Dinner Plan'),
      ];
    } catch (e) {
      print('Error fetching meal plans: $e');
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plans'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Failed to load meal plans.'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchMealPlans,
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : mealPlans.isEmpty
          ? Center(child: Text('No meal plans available.'))
          : RefreshIndicator(
        onRefresh: fetchMealPlans,
        child: ListView.builder(
          itemCount: mealPlans.length,
          itemBuilder: (context, index) {
            final mealPlan = mealPlans[index];
            return ListTile(
              title: Text(mealPlan.name),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void downloadMealPlan(List<String> meals) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: meals.map((meal) => pw.Text(meal)).toList(),
        );
      },
    ),
  );

  final outputDirectory = await getTemporaryDirectory();
  final file = File('${outputDirectory.path}/meal_plan.pdf');

  await file.writeAsBytes(await pdf.save());

  print('Meal plan downloaded to: ${file.path}');
}

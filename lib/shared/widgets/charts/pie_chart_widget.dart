import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    super.key,
    required this.seriesList,
    required this.animate,
  });

  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  /// Creates a [PieChart] with sample data and no transition.
  factory PieChartWidget.withSampleData() {
    return PieChartWidget(
      seriesList: _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.PieChart<String>(
      seriesList,
      animate: animate,
        // Add an [ArcLabelDecorator] configured to render labels outside of the
        // arc with a leader line.
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: charts.TextStyleSpec(...)),
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 60,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              constraintLabels: false,
              outsideLabelStyleSpec: const charts.TextStyleSpec(fontSize: 10, fontFamily: "Effra"),
              labelPosition: charts.ArcLabelPosition.outside
            )
          ]
        )
        // defaultRenderer: charts.ArcRendererConfig(arcWidth: 60)

    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      LinearSales("Americano", "10"),
      LinearSales("Caramel latte", "30"),
      LinearSales("Cappuccino latte", "55"),
      LinearSales("Espresso", "5"),
    ];

    return [
      charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.label,
        measureFn: (LinearSales sales, _) => int.tryParse(sales.sales),
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => "${row.label}: ${row.sales}",
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String label;
  final String sales;

  LinearSales(this.label, this.sales);
}
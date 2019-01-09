import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final double percentage;
  final Color gaugeColor;

  GaugeChart(this.seriesList, this.percentage, {this.animate, this.gaugeColor});

  /// Creates a [PieChart] with sample data and no transition.
  factory GaugeChart.withSampleData(perc, col) {
    return new GaugeChart(
      _createSampleData(),
      perc,
      // Disable animations for image tests.
      animate: false,
      gaugeColor: col,
    );
  }

  // // EXCLUDE_FROM_GALLERY_DOCS_START
  // // This section is excluded from being copied to the gallery.
  // // It is used for creating random series data to demonstrate animation in
  // // the example app only.
  // factory GaugeChart.withRandomData() {
  //   return new GaugeChart(_createRandomData());
  // }

  // /// Create random data.
  // static List<charts.Series<GaugeSegment, String>> _createRandomData() {
  //   final random = new Random();

  //   final data = [
  //     new GaugeSegment('Low', random.nextInt(100)),
  //     new GaugeSegment('Acceptable', random.nextInt(100)),
  //     new GaugeSegment('High', random.nextInt(100)),
  //     new GaugeSegment('Highly Unusual', random.nextInt(100)),
  //   ];

  //   return [
  //     new charts.Series<GaugeSegment, String>(
  //       id: 'Segments',
  //       domainFn: (GaugeSegment segment, _) => segment.segment,
  //       measureFn: (GaugeSegment segment, _) => segment.size,
  //       data: data,
  //     )
  //   ];
  // }
  // // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        layoutConfig: new charts.LayoutConfig(
          leftMarginSpec: new charts.MarginSpec.fixedPixel(0),
          topMarginSpec: new charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: new charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: new charts.MarginSpec.fixedPixel(0)
        ),
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 10, startAngle: 0.7 * pi, arcLength: (percentage / 100) * 1.6 * pi)
    );

  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Low', 85),
      // new GaugeSegment('Acceptable', 100),
      // new GaugeSegment('High', 50),
      // new GaugeSegment('Highly Unusual', 53),
    ];
    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault, 
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
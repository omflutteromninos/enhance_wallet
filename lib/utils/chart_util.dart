import 'dart:ui';

import 'package:cPocket/utils/view_utils/dimens.dart';
import 'package:cPocket/utils/view_utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'view_utils/colors.dart';
import 'view_utils/decorations.dart';
import 'view_utils/text_utils.dart';

class ChartUtil {
  static const List<String> monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  /// *** SPLINE *** ///

  static List<ChartData> getChartDataFullMonth(
      List<num> yDeposit, List<num> yWithdraw) {
    List<ChartData> chartData = <ChartData>[];
    for (var i = 0; i < yDeposit.length; i++) {
      chartData.add(ChartData(
          x: monthList[i], y: yDeposit[i], secondSeriesYValue: yWithdraw[i]));
    }
    return chartData;
  }

  static List<ChartData> getChartDataFullMonth1(List<num> yData) {
    List<ChartData> chartData = <ChartData>[];
    for (var i = 0; i < yData.length; i++) {
      chartData.add(ChartData(x: monthList[i], y: yData[i]));
    }
    return chartData;
  }

//for two line data
  List<SplineSeries<ChartData, String>> getSplineSeries(
      List<ChartData> chartSeries) {
    return <SplineSeries<ChartData, String>>[
      SplineSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.y,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'Deposit',
          width: 3,
          color: kGreenColor),
      SplineSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.secondSeriesYValue,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'withdraw',
          width: 3,
          color: kRedColor),
    ];
  }

//for one line data
  List<SplineSeries<ChartData, String>> getSplineSeries1(
      List<ChartData> chartSeries,
      {Color? lineColor}) {
    Color colorL = lineColor ?? accent;
    return <SplineSeries<ChartData, String>>[
      SplineSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.y,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'trade_history',
          width: 3,
          color: colorL),
    ];
  }

  Widget buildSplineChart(List<double> yDeposit, List<double> yWithdraw) {
    var dataObjects = getChartDataFullMonth(yDeposit, yWithdraw);
    var dataSeries = getSplineSeries(dataObjects);

    var width = Get.width / 1.75;

    var maxDeposit = getMaxMinDoubleList(yDeposit, true);
    var maxWithdraw = getMaxMinDoubleList(yWithdraw, true);
    var minDeposit = getMaxMinDoubleList(yDeposit, false);
    var minWithdraw = getMaxMinDoubleList(yWithdraw, false);

    return Container(
      //height: width + 113,
      height: 332,
      //margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10),
      decoration: getRoundSoftTransparentBox(),
      child: Column(
        children: [
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                labelPlacement: LabelPlacement.onTicks),
            primaryYAxis: NumericAxis(
              minimum: minDeposit < minWithdraw ? minDeposit : minWithdraw,
              maximum: maxDeposit > maxWithdraw ? maxDeposit : maxWithdraw,
              axisLine: const AxisLine(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.none,
              majorGridLines:
                  const MajorGridLines(width: 0.2, color: Colors.grey),
            ),
            series: dataSeries,
            tooltipBehavior: TooltipBehavior(enable: false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: getRoundBox(color: kGreenColor),
                  height: 11,
                  width: 11),
              HSpacer10(),
              textAutoSize("Deposit".tr, width: 45, fontSize: 14),
              HSpacer20(),
              Container(
                  decoration: getRoundBox(color: kRedColor),
                  height: 11,
                  width: 11),
              HSpacer10(),
              textAutoSize("Withdraw".tr, width: 55, fontSize: 14),
            ],
          ),
          VSpacer5(),
        ],
      ),
    );
  }

  Widget buildSplineChart1(List<double> yData, {Color? lineColor}) {
    var dataObjects = getChartDataFullMonth1(yData);
    var dataSeries = getSplineSeries1(dataObjects, lineColor: lineColor);
    return Container(
      height: Get.width / 1.75,
      //margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10),
      decoration: getRoundSoftTransparentBox(),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            labelPlacement: LabelPlacement.onTicks),
        primaryYAxis: NumericAxis(
          minimum: getMaxMinDoubleList(yData, false),
          maximum: getMaxMinDoubleList(yData, true),
          axisLine: const AxisLine(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.none,
          majorGridLines: const MajorGridLines(width: 0.2, color: Colors.grey),
        ),
        series: dataSeries,
        tooltipBehavior: TooltipBehavior(enable: false),
      ),
    );
  }

  /// *** BAR *** ///

  static List<ChartData> getChartDataSixMonth(List<num> yBuyCoin) {
    print(yBuyCoin.length);
    List<ChartData> chartData = <ChartData>[];
    // for (var i = 0; i < monthList.length; i++) {
    //   chartData.add(ChartData(x: monthList[i], y: yBuyCoin[i]));
    // }
    for (var i = 0; i < yBuyCoin.length; i++) {
      chartData.add(ChartData(x: monthList[i], y: yBuyCoin[i]));
    }
    return chartData;
  }

  static List<ChartData> getChartDataSixMonth2(
      List<String> yMonth, List<num> yBuy, List<num> ySell) {
    List<ChartData> chartData = <ChartData>[];
    for (var i = 0; i < yMonth.length; i++) {
      chartData.add(
          ChartData(x: yMonth[i], y: yBuy[i], secondSeriesYValue: ySell[i]));
    }
    return chartData;
  }

  List<BarSeries<ChartData, String>> getBarSeries(List<ChartData> chartSeries) {
    return <BarSeries<ChartData, String>>[
      BarSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.y,
          spacing: 0.5,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'buy_bar',
          width: 1.0,
          color: brightTurquoise),
    ];
  }

  List<BarSeries<ChartData, String>> getBarSeries2(
      List<ChartData> chartSeries) {
    return <BarSeries<ChartData, String>>[
      BarSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.secondSeriesYValue,
          spacing: 0.5,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'sell_bar',
          width: 0.5,
          color: razzleDazzleRose),
      BarSeries<ChartData, String>(
          dataSource: chartSeries,
          xValueMapper: (ChartData data, _) => data.x as String,
          yValueMapper: (ChartData data, _) => data.y,
          spacing: 0.5,

          ///markerSettings: const MarkerSettings(isVisible: false),
          name: 'buy_bar',
          width: 0.5,
          color: brightTurquoise),
    ];
  }

  Widget buildBarChart(List<double> yBuyCoin) {
    var dataObjects = getChartDataSixMonth(yBuyCoin);
    var dataSeries = getBarSeries(dataObjects);
    var width = Get.width / 1.75;
    var maxBuyCoin = getMaxMinDoubleList(yBuyCoin, true);
    var minBuyCoin = getMaxMinDoubleList(yBuyCoin, false);

    return Container(
      height: width+10,
      padding: const EdgeInsets.only(top: 10,right: 10),
      decoration: getRoundSoftTransparentBox(),
      child: Column(
        children: [
          SizedBox(
            height: width,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: NumericAxis(
                minimum: minBuyCoin,
                maximum: maxBuyCoin,
                axisLine: const AxisLine(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.none,
                majorGridLines:
                    const MajorGridLines(width: 0.2, color: Colors.grey),
              ),
              series: dataSeries,
              tooltipBehavior: TooltipBehavior(enable: false),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBarChart2(
      List<String> yMonth, List<double> yBuy, List<double> ySell) {
    var dataObjects = getChartDataSixMonth2(yMonth, yBuy, ySell);
    var dataSeries = getBarSeries2(dataObjects);
    var width = Get.width / 1.75;
    var maxBuy = getMaxMinDoubleList(yBuy, true);
    var maxSell = getMaxMinDoubleList(ySell, true);
    var minBuy = getMaxMinDoubleList(yBuy, false);
    var minSell = getMaxMinDoubleList(ySell, false);

    return Container(
      height: width + 30,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10),
      decoration: boxDecorationRoundCorner(
          color: Get.theme.primaryColorDark.withOpacity(0.5)),
      child: Column(
        children: [
          SizedBox(
            height: width,
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                  labelPlacement: LabelPlacement.onTicks),
              primaryYAxis: NumericAxis(
                minimum: minBuy < minSell ? minBuy : minSell,
                maximum: maxBuy > maxSell ? maxBuy : maxSell,
                axisLine: const AxisLine(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.none,
                majorGridLines:
                    const MajorGridLines(width: 0.2, color: Colors.grey),
              ),
              series: dataSeries,
              tooltipBehavior: TooltipBehavior(enable: false),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 10, width: 10, color: brightTurquoise),
              textAutoSize("Buy".tr, width: 30, fontSize: 12),
              Container(height: 10, width: 10, color: razzleDazzleRose),
              textAutoSize("Sell".tr, width: 30, fontSize: 12),
            ],
          )
        ],
      ),
    );
  }

  double getMaxMinDoubleList(List<double>? data, bool isMax) {
    if (data != null && data.isNotEmpty) {
      if (isMax) {
        return data
            .reduce((value, element) => value > element ? value : element);
      } else {
        return data
            .reduce((value, element) => value < element ? value : element);
      }
    }
    return 0;
  }
}

class ChartData {
  ChartData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}

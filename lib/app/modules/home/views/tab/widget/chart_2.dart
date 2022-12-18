import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simas/app/data/models/titik_pantau_model.dart';
import 'package:simas/app/modules/home/controllers/home_controller.dart';
import 'package:simas/app/modules/home/controllers/tab/titik_pantau_controller.dart';

const List<Color> colors = [
  Colors.amber,
  Colors.green,
  Colors.pink,
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.black,
  Colors.indigo,
  Colors.grey,
  Colors.teal,
  Colors.lime,
  Colors.cyan,
  Colors.brown,
  Colors.deepPurple,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.deepOrangeAccent,
  Colors.indigoAccent,
  Colors.lightGreenAccent,
  Colors.limeAccent
];

class _LineChart extends StatelessWidget {
  final List<dynamic> data;
  final String? parameter;
  final List<bool> listShow;
  const _LineChart(
      {this.parameter, required this.listShow, required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(sampleData1);
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 9,
        maxY: List.generate(
                lineBarsData1.length,
                (index) =>
                    lineBarsData1[index].spots.map((e) => e.y).toList().reduce(
                        (value, element) => value > element ? value : element) *
                    1.25)
            .reduce((value, element) => value > element ? value : element),
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey,
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );
  List<LineChartBarData> get lineBarsData1 {
    List<int> indexOfTitikPantau = [];
    for (var i = 0; i < listShow.length; i++) {
      if (listShow[i]) {
        indexOfTitikPantau.add(i);
      }
    }
    final result = List.generate(
        listShow.where((element) => element).toList().length, (index) {
      var d = data
          .where((element) => (element['kualitas'] as List).isNotEmpty)
          .toList();
      List<FlSpot> spots = [];
      for (var i = 0; i < 10; i++) {
        if (i < d.length && parameter != null) {
          var kualitas = (d[i]['kualitas'] as List)
              .where((element) =>
                  element['titik_pantau']['nama'] ==
                  Get.find<HomeController>().titikPantau[index].nama)
              .toList();
          if (kualitas.isNotEmpty) {
            spots.add(FlSpot(9 - i.toDouble(),
                double.tryParse(kualitas[0][parameter].toString()) ?? 0));
          } else {
            spots.add(FlSpot(9 - i.toDouble(), 0));
          }
        } else {
          spots.add(FlSpot(9 - i.toDouble(), 0));
        }
      }

      return LineChartBarData(
        isCurved: false,
        color: colors[index],
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots,
      );
    });
    if (result.isNotEmpty) {
      return result;
    } else {
      return [
        LineChartBarData(
          isCurved: false,
          color: colors[0],
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 0),
            FlSpot(1, 0),
            FlSpot(2, 0),
            FlSpot(3, 0),
            FlSpot(4, 0),
            FlSpot(5, 0),
            FlSpot(6, 0),
            FlSpot(7, 0),
            FlSpot(8, 0),
            FlSpot(9, 0),
          ],
        )
      ];
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    var max = List.generate(
        lineBarsData1.length,
        (index) =>
            lineBarsData1[index]
                .spots
                .map((e) => e.y)
                .toList()
                .reduce((value, element) => value > element ? value : element) *
            1.25).reduce((value, element) => value > element ? value : element);
    if (max <= 0.1) {
      if (value % 0.02 == 0) {
        return Text(value.toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 1) {
      if (value % 0.2 == 0) {
        return Text(value.toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 2) {
      if (value % 0.4 == 0) {
        return Text(value.toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 5) {
      if (value % 1 == 0) {
        return Text(value.toInt().toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 10) {
      if (value % 2 == 0) {
        return Text(value.toInt().toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 20) {
      if (value % 4 == 0) {
        return Text(value.toInt().toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (max <= 50) {
      if (value % 10 == 0) {
        return Text(value.toInt().toString(),
            style: style, textAlign: TextAlign.center);
      }
    }
    if (value % 20 == 0) {
      return Text(value.toInt().toString(),
          style: style, textAlign: TextAlign.center);
    }
    return const SizedBox.shrink();
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var d = data.map((e) => e['tahun']).toList();
    int awalTahun = 0;
    if (data.isNotEmpty) {
      awalTahun =
          (int.tryParse(data.first['tahun']) ?? DateTime.now().year) - 4;
    } else {
      awalTahun = DateTime.now().year - 4;
    }
    List<int> tahun =
        List.generate(5, (index) => int.parse((awalTahun + index).toString()));
    var t = data.map((e) => e['tahap']).toList();
    int tahap = 2;
    if (t.isNotEmpty) {
      tahap = int.tryParse(t.first) ?? 2;
    }
    var tahunIndex = 0;
    var tahunReversed = tahun.reversed.toList();
    List<String> tahunTahap = List.generate(10, (index) {
      var tahunXtahap = tahunIndex >= tahunReversed.length
          ? "${tahunReversed[4] - 1} ($tahap)"
          : "${tahunReversed[tahunIndex]} ($tahap)";
      if (tahap == 1) {
        tahap = 2;
        tahunIndex++;
      } else {
        tahap--;
      }
      return tahunXtahap;
    });

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 12,
      space: 10,
      child: Text(
        tahunTahap.reversed.toList()[value.toInt()],
        style: const TextStyle(
          color: Color(0xff7589a2),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 1),
          left: BorderSide(color: Color(0xff4e4965), width: 1),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
}

class LineChartSample1 extends StatelessWidget {
  final List<dynamic> data;
  final String? parameter;
  final List<bool> listShow;
  const LineChartSample1(
      {super.key, required this.data, this.parameter, required this.listShow});
  @override
  Widget build(BuildContext context) {
    List<int> indexOfTitikPantau = [];
    for (var i = 0; i < listShow.length; i++) {
      if (listShow[i]) {
        indexOfTitikPantau.add(i);
      }
    }
    return AspectRatio(
        aspectRatio: 1,
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(
                    parameter: parameter,
                    data: data,
                    listShow: listShow,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Wrap(
                spacing: 4,
                alignment: WrapAlignment.center,
                children: [
                  ...List.generate(indexOfTitikPantau.length, (index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors[index],
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(((Get.find<HomeController>().titikPantau.isNotEmpty
                                    ? (Get.find<HomeController>()
                                            .titikPantau[
                                                indexOfTitikPantau[index]]
                                            .nama
                                            ?.length ??
                                        0)
                                    : 0) >
                                20)
                            ? "${Get.find<HomeController>().titikPantau[indexOfTitikPantau[index]].nama?.substring(0, 20)}..."
                            : Get.find<HomeController>()
                                    .titikPantau[indexOfTitikPantau[index]]
                                    .nama ??
                                ''),
                      ],
                    );
                  }),
                ],
              )
            ],
          ),
        ));
  }
}

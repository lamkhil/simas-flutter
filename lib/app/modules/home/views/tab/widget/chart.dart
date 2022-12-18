import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarIndeksKualitasAir extends StatefulWidget {
  final List<dynamic> data;
  const BarIndeksKualitasAir({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => BarIndeksKualitasAirState();
}

class BarIndeksKualitasAirState extends State<BarIndeksKualitasAir> {
  final Color leftBarColor = const Color(0xFF147AD6);
  final Color rightBarColor = const Color(0xFFE76464);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late List<Map<String, dynamic>> data;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      data = widget.data.map<Map<String, dynamic>>((e) => e).toList();
      int awalTahun = (int.tryParse(data.first['tahun'].toString()) ??
              DateTime.now().year) -
          4;
      List<BarChartGroupData> dataItem = [];
      List<int> tahun = List.generate(5, (index) => awalTahun + index);
      for (var i = 0; i < 5; i++) {
        var group = data
            .where(
                (element) => int.parse(element['tahun'].toString()) == tahun[i])
            .toList();
        if (group.isNotEmpty) {
          if (group.length > 1) {
            dataItem.add(makeGroupData(
                i,
                double.parse(group[1]['ika'].toString()),
                double.parse(group[0]['ika'].toString())));
          } else {
            if (int.parse(group[0]['tahap'].toString()) == 1) {
              dataItem.add(makeGroupData(
                  i, double.parse(group[0]['ika'].toString()), 0));
            } else {
              dataItem.add(makeGroupData(
                  i, 0, double.parse(group[0]['ika'].toString())));
            }
          }
        } else {
          dataItem.add(makeGroupData(i, 0, 0));
        }
      }

      rawBarGroups = dataItem;

      showingBarGroups = rawBarGroups;
    } else {
      rawBarGroups = [
        makeGroupData(0, 0, 0),
        makeGroupData(0, 0, 0),
        makeGroupData(0, 0, 0),
        makeGroupData(0, 0, 0),
        makeGroupData(0, 0, 0),
      ];

      showingBarGroups = rawBarGroups;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 100,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (a, b, c, d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod
                                in showingBarGroups[touchedGroupIndex]
                                    .barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum /
                                showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .length;

                            showingBarGroups[touchedGroupIndex] =
                                showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .map((rod) {
                                return rod.copyWith(toY: avg);
                              }).toList(),
                            );
                          }
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFF147AD6)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("Kemarau"),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFE76464)),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text("Penghujan"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value % 20 == 0) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(value.toInt().toString(), style: style),
      );
    }
    return Container();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    data = widget.data.map<Map<String, dynamic>>((e) => e).toList();
    int awalTahun = 0;
    if (data.isNotEmpty) {
      awalTahun =
          (int.tryParse(data.first['tahun']) ?? DateTime.now().year) - 4;
    } else {
      awalTahun = DateTime.now().year - 4;
    }
    List<String> tahun =
        List.generate(5, (index) => (awalTahun + index).toString());

    final Widget text = Text(
      tahun[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: rightBarColor,
          width: width,
        ),
      ],
    );
  }
}

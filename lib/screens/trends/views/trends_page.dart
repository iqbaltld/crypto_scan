import 'package:crypto_scan/extensions/num.dart';
import 'package:crypto_scan/screens/trends/trends.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class TrendsPage extends StatelessWidget {
  const TrendsPage({super.key, required this.symbol});
  final String symbol;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendsBloc(symbol)..add(const TrendsEvent.started()),
      child: BlocBuilder<TrendsBloc, TrendsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('$symbol Trends')),
            body: state.maybeWhen(
              success: (realTimePrice, historicalPrices, times) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          'Current Price: \$${realTimePrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: LineChart(
                          LineChartData(
                            borderData: FlBorderData(show: true),
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                spots: times
                                    .asMap()
                                    .entries
                                    .map((e) => FlSpot(e.key.toDouble(),
                                        historicalPrices[e.key]))
                                    .toList(),
                              ),
                            ],
                            titlesData: FlTitlesData(
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles:
                                            false) // Hide right axis titles
                                    ),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(
                                        showTitles:
                                            false) // Hide top axis titles
                                    ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 6,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      final DateTime time =
                                          times[value.toInt()];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                          DateFormat('h:mm a').format(time),
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.formatNumber(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Trends analysis for the past 24 hours.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  ],
                );
              },
              error: (message) => Center(child: Text(message)),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

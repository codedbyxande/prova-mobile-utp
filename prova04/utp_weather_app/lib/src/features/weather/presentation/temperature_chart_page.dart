import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:utp_app_climatico/src/constants/app_colors.dart';
import 'package:utp_app_climatico/src/features/weather/application/providers.dart';
import 'package:utp_app_climatico/src/features/weather/data/api_exception.dart';

class TemperatureChartPage extends ConsumerWidget {
  const TemperatureChartPage({super.key, required this.city});

  final String city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(detailedWeatherProvider(city));
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Gráfico de Temperatura - $city',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: weatherDataValue.when(
        data: (weatherData) => TemperatureChartContents(data: weatherData),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.accent,
          ),
        ),
        error: (e, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              Text(
                e is APIException ? e.message : 'Erro ao carregar dados do clima',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureChartContents extends StatelessWidget {
  const TemperatureChartContents({super.key, required this.data});
  final DetailedWeatherData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChartSection(context),
          const SizedBox(height: 32),
          _buildStatsSection(context),
        ],
      ),
    );
  }

  Widget _buildChartSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Previsão de Temperatura - 5 Dias',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 5,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.divider,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: AppColors.divider,
                      strokeWidth: 1,
                    );
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
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() >= 0 && value.toInt() < data.forecast.list.length) {
                          final forecast = data.forecast.list[value.toInt()];
                          final dateFormat = DateFormat('d/MM', 'pt_BR');
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              dateFormat.format(forecast.date),
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '${value.toInt()}°',
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                      reservedSize: 42,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: AppColors.divider),
                ),
                minX: 0,
                maxX: (data.forecast.list.length - 1).toDouble(),
                minY: _getMinTemperature(),
                maxY: _getMaxTemperature(),
                lineBarsData: [
                  // Current temperature line
                  LineChartBarData(
                    spots: _getTemperatureSpots(),
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent,
                        AppColors.accent.withOpacity(0.8),
                      ],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: AppColors.accent,
                          strokeWidth: 2,
                          strokeColor: AppColors.background,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent.withOpacity(0.3),
                          AppColors.accent.withOpacity(0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Temperatura', AppColors.accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    // Find coldest and warmest temperatures
    final coldest = data.forecast.list.reduce((a, b) => 
        a.temp.celsius < b.temp.celsius ? a : b);
    final warmest = data.forecast.list.reduce((a, b) => 
        a.temp.celsius > b.temp.celsius ? a : b);
    
    final dateFormat = DateFormat('d/MM, HH:mm', 'pt_BR');
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estatísticas de Temperatura',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildStatRow(
            'Temperatura Mais Baixa',
            dateFormat.format(coldest.date),
            '${coldest.temp.celsius.toInt()}°',
            Icons.ac_unit,
            AppColors.accent,
          ),
          _buildStatRow(
            'Temperatura Mais Alta',
            dateFormat.format(warmest.date),
            '${warmest.temp.celsius.toInt()}°',
            Icons.wb_sunny,
            AppColors.accent,
          ),
          _buildStatRow(
            'Temperatura Atual',
            'Agora',
            '${data.current.temp.celsius.toInt()}°',
            Icons.thermostat,
            AppColors.success,
          ),
          _buildStatRow(
            'Temperatura Média',
            '5 dias',
            '${_getAverageTemperature().toInt()}°',
            Icons.trending_up,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String subtitle, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _getTemperatureSpots() {
    return data.forecast.list.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.temp.celsius);
    }).toList();
  }

  double _getMinTemperature() {
    final minTemp = data.forecast.list.map((f) => f.temp.celsius).reduce((a, b) => a < b ? a : b);
    return (minTemp - 5).floorToDouble();
  }

  double _getMaxTemperature() {
    final maxTemp = data.forecast.list.map((f) => f.temp.celsius).reduce((a, b) => a > b ? a : b);
    return (maxTemp + 5).ceilToDouble();
  }

  double _getAverageTemperature() {
    final temps = data.forecast.list.map((f) => f.temp.celsius);
    return temps.reduce((a, b) => a + b) / temps.length;
  }
} 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:utp_app_climatico/src/constants/app_colors.dart';
import 'package:utp_app_climatico/src/features/weather/application/providers.dart';
import 'package:utp_app_climatico/src/features/weather/data/api_exception.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/weather_icon_image.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/temperature_chart_page.dart';

class DetailedWeatherPage extends ConsumerWidget {
  const DetailedWeatherPage({super.key, required this.city});

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
          city,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.show_chart, color: AppColors.primary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TemperatureChartPage(city: city),
                ),
              );
            },
          ),
        ],
      ),
      body: weatherDataValue.when(
        data: (weatherData) => DetailedWeatherContents(data: weatherData),
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

class DetailedWeatherContents extends StatelessWidget {
  const DetailedWeatherContents({super.key, required this.data});
  final DetailedWeatherData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentWeatherSection(context),
          const SizedBox(height: 32),
          _buildWeatherDetailsSection(context),
          const SizedBox(height: 32),
          _buildForecastSection(context),
        ],
      ),
    );
  }

  Widget _buildCurrentWeatherSection(BuildContext context) {
    final current = data.current;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          WeatherIconImage(iconUrl: current.iconUrl, size: 80),
          const SizedBox(height: 16),
          Text(
            '${current.temp.celsius.toInt()}°',
            style: textTheme.displayLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            current.description,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${current.maxTemp.celsius.toInt()}° / ${current.minTemp.celsius.toInt()}°',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsSection(BuildContext context) {
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
            'Informações do Clima',
            style: textTheme.headlineSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Temperatura Atual', '${data.current.temp.celsius.toInt()}°', Icons.thermostat),
          _buildDetailRow('Temperatura Máxima', '${data.current.maxTemp.celsius.toInt()}°', Icons.trending_up),
          _buildDetailRow('Temperatura Mínima', '${data.current.minTemp.celsius.toInt()}°', Icons.trending_down),
          _buildDetailRow('Descrição do Clima', data.current.description, Icons.info_outline),
          _buildDetailRow('Data', DateFormat('EEEE, d \'de\' MMMM \'de\' y', 'pt_BR').format(data.current.date), Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previsão de 5 Dias',
          style: textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        ...data.forecast.list.map((forecast) => _buildForecastItem(context, forecast)),
      ],
    );
  }

  Widget _buildForecastItem(BuildContext context, forecast) {
    final textTheme = Theme.of(context).textTheme;
    final dateFormat = DateFormat('EEEE, d \'de\' MMM', 'pt_BR');
    final timeFormat = DateFormat('HH:mm');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateFormat.format(forecast.date),
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  timeFormat.format(forecast.date),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  forecast.description,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          WeatherIconImage(iconUrl: forecast.iconUrl, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${forecast.temp.celsius.toInt()}°',
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${forecast.maxTemp.celsius.toInt()}° / ${forecast.minTemp.celsius.toInt()}°',
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
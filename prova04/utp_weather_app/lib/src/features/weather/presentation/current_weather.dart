import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:utp_app_climatico/src/constants/app_colors.dart';
import 'package:utp_app_climatico/src/features/weather/application/providers.dart';
import 'package:utp_app_climatico/src/features/weather/data/api_exception.dart';
import 'package:utp_app_climatico/src/features/weather/domain/weather/weather_data.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/weather_icon_image.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/detailed_weather_page.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          city,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        weatherDataValue.when(
          data: (weatherData) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailedWeatherPage(city: city),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider.withOpacity(0.3)),
              ),
              child: CurrentWeatherContents(data: weatherData),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: AppColors.accent,
            ),
          ),
          error: (e, __) => Text(
            e is APIException ? e.message : e.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = '$maxTemp° / $minTemp°';
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        const SizedBox(height: 16),
        Text(
          '$temp°',
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          highAndLow,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.accent,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              'Toque para previsão detalhada',
              style: textTheme.bodySmall?.copyWith(
                color: AppColors.accent,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

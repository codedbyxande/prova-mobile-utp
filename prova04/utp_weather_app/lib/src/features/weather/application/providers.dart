import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather_data.dart';

final cityProvider = StateProvider<String>((ref) {
  return 'Curitiba';
});

final currentWeatherProvider =
    FutureProvider.autoDispose<WeatherData>((ref) async {
  final city = ref.watch(cityProvider);
  final weather =
      await ref.watch(weatherRepositoryProvider).getWeather(city: city);
  return WeatherData.from(weather);
});

final hourlyWeatherProvider =
    FutureProvider.autoDispose<ForecastData>((ref) async {
  final city = ref.watch(cityProvider);
  final forecast =
      await ref.watch(weatherRepositoryProvider).getForecast(city: city);
  return ForecastData.from(forecast);
});

// Combined provider for detailed weather view using free API endpoints
final detailedWeatherProvider = FutureProvider.autoDispose.family<DetailedWeatherData, String>((ref, city) async {
  final repository = ref.watch(weatherRepositoryProvider);
  
  // Get both current weather and forecast data
  final weather = await repository.getWeather(city: city);
  final forecast = await repository.getForecast(city: city);
  
  return DetailedWeatherData(
    current: WeatherData.from(weather),
    forecast: ForecastData.from(forecast),
  );
});

// Data class for detailed weather view
class DetailedWeatherData {
  DetailedWeatherData({
    required this.current,
    required this.forecast,
  });

  final WeatherData current;
  final ForecastData forecast;
}

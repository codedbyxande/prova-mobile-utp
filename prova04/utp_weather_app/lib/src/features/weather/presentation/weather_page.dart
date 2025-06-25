import 'package:flutter/material.dart';
import 'package:utp_app_climatico/src/constants/app_colors.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/city_search_box.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/current_weather.dart';
import 'package:utp_app_climatico/src/features/weather/presentation/hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CitySearchBox(),
              const SizedBox(height: 60),
              const CurrentWeather(),
              const SizedBox(height: 60),
              const HourlyWeather(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

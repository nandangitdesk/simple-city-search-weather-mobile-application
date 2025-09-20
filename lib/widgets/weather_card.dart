import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(142, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color.fromARGB(63, 0, 0, 0), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(25, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                weather.description.toLowerCase().contains('rain')
                    ? 'assets/rain.json'
                    : weather.description.toLowerCase().contains('clear')
                    ? 'assets/sunny.json'
                    : 'assets/cloudy.json',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),

              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              SizedBox(height: 8),

              Text(
                '${weather.temperature.toStringAsFixed(1)} °C',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.water_drop, color: Colors.blue),
                  
                  Text(
                    '${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 24),
                  Icon(Icons.air, color: Colors.grey),
                 
                  Text(
                    '${weather.windSpeed} m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.orange),
                      SizedBox(height: 4),
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.nights_stay, color: Colors.indigo),
                      SizedBox(height: 4),
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 4),
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  // Weather service methods would go here
  final String apiKey = '0ae1fbf2cb7f78a27d4161bb0de9e2d2';

  Future<WeatherModel> fetchWeather(String cityName) async {
    // Implementation for fetching weather data from an API
    // This is a placeholder implementation
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
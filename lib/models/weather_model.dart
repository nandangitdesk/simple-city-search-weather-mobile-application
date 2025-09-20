class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? "Unknown",
      temperature: (json['main']['temp'] ?? 0).toDouble() - 273.15, // Kelvin → Celsius
      description: (json['weather'] as List).isNotEmpty
          ? json['weather'][0]['description'] ?? "No description"
          : "No description",
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] ?? 0).toDouble(),
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
    );
  }
}

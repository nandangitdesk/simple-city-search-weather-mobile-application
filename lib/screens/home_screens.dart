import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService weatherService = WeatherService();

  bool _isLoading = false;

  WeatherModel? _weatherData;

  void fetchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      WeatherModel weather = await weatherService.fetchWeather(
        _cityController.text,
      );
      setState(() {
        _weatherData = weather;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              _weatherData != null &&
                  _weatherData!.description.toLowerCase().contains('rain')
              ? const LinearGradient(
                  colors: [Colors.blueGrey, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : _weatherData != null &&
                    _weatherData!.description.toLowerCase().contains('clear')
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.black12],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              children: [
                SizedBox(height: 100),

                Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 20),

                TextField(
                  controller: _cityController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Color.fromARGB(115, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _isLoading ? null : fetchWeather,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Get Weather',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),

                if (_weatherData != null) WeatherCard(weather: _weatherData!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

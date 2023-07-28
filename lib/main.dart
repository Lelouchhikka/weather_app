import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/src/api/weather_api.dart';
import 'package:weather_app/src/models/weather_model.dart';
void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final WeatherApi weatherApi = WeatherApi('a4cb8e1f45deeca524d7bdbba20100ae', 'https://api.openweathermap.org/data/2.5/weather');
  final TextEditingController cityController = TextEditingController();
  WeatherModel? weather;

  void getWeatherData() async {
    try {
      final cityName = cityController.text.trim();
      final result = await weatherApi.getWeather(cityName);
      setState(() {
        weather = result;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (weather != null)
                Column(
                  children: [
                    Text(
                      '${weather!.cityName}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${weather!.temperature.toStringAsFixed(1)}°C',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${weather!.weatherDescription}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    SvgPicture.network(
                      'https://openweathermap.org/img/w/${weather!.iconCode}.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: getWeatherData,
                child: Text('Get Weather'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

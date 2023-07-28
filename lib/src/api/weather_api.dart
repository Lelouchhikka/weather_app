import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherApi {
  final String apiKey;
  final String baseUrl;

  WeatherApi(this.apiKey, this.baseUrl);

  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return WeatherModel.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

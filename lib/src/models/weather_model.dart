class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherDescription;
  final String iconCode;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.iconCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}

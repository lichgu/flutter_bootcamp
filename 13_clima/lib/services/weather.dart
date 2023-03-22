/*
see https://pub.dev/packages/geolocator for example including checking if the
location services are enabled and checking / requesting permission to access the
position of the device
 */
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String kBaseUrl = 'api.openweathermap.org';
const String kApiKeyOpenWeatherMap = 'cb57a6ff25916d1099802104b8a6e0e3';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Uri url = Uri.https(kBaseUrl, '/data/2.5/weather',
        {'q': cityName, 'appid': kApiKeyOpenWeatherMap, 'units': 'metric'});
    NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation().timeout(
            const Duration(seconds: 10),
          );
      String latitude = location.latitude.toString();
      String longitude = location.longitude.toString();

      Uri url = Uri.https(kBaseUrl, '/data/2.5/weather', {
        'lat': latitude,
        'lon': longitude,
        'appid': kApiKeyOpenWeatherMap,
        'units': 'metric'
      });
      NetworkHelper networkHelper = NetworkHelper(url: url);
      return await networkHelper.getData();
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

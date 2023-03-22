import 'package:http/http.dart' as http;
import 'dart:convert';

const String kBaseUrl = 'rest.coinapi.io';
String kCoinApiKey = '18B632AC-0D1B-45A6-A576-86ADBBB79016';
//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=18B632AC-0D1B-45A6-A576-86ADBBB79016

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];

const Map<String, String> cryptoNames = {
  'BTC': 'Bitcoin',
  'ETH': 'Ethereum',
  'LTC': 'Litecoin',
};

const Map<String, String> cryptoLogos = {
  'BTC': 'bitcoin-btc-logo.png',
  'ETH': 'ethereum-eth-logo.png',
  'LTC': 'litecoin-ltc-logo.png',
};

class CoinData {
  // TODO: add method to reset stored rates when app is started and after time interval

  Map<String, Map<String, double>> rates = {};

  CoinData() {
    _initRates();
  }

  void _initRates() {
    for (String currency in cryptoList) {
      rates[currency] = {};
    }
  }

  Future<dynamic> getCoinData(
      {String assetIdBase = 'BTC', String assetIdQuote = 'USD'}) async {
    if (rates[assetIdBase]!.containsKey(assetIdQuote)) {
      return rates[assetIdBase]![assetIdQuote];
    }

    Uri url = Uri.https(kBaseUrl, 'v1/exchangerate/$assetIdBase/$assetIdQuote',
        {'apiKey': kCoinApiKey});
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      double rate = jsonDecode(response.body)['rate'];
      rates[assetIdBase]![assetIdQuote] = rate;
      return rate;
    } else {
      print('Something went wrong ($response.statusCode)');
      throw 'Problem with the get request';
    }
  }

  Future<dynamic> getCoinRates({required String currency}) async {
    Map<String, double> currentRates = {};
    try {
      for (String cryptoCurrency in cryptoList) {
        currentRates[cryptoCurrency] = await getCoinData(
            assetIdBase: cryptoCurrency, assetIdQuote: currency);
      }
      return currentRates;
    } catch (e) {
      rethrow;
    }
  }
}

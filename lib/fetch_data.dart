import 'package:demo_app/API_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FetchData {

  String currency;
  FetchData({required this.currency});

  Future<double> getData() async {
    final url = Uri.parse(
      'https://v6.exchangerate-api.com/v6/$OPEN_WEATHER_API/latest/USD',
    );
    final response = await http.get(url);

    final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return data['conversion_rates'][currency];
  }
}

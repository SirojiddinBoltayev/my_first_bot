import 'dart:convert';

import '../model/exchange_model.dart';
import 'package:http/http.dart' as http;

Future<List<CurrencyRate>?> getCurrencyRate() async {
  var url = 'https://nbu.uz/uz/exchange-rates/json/';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var currencyRate = <CurrencyRate>[];
    for (var item in data) {
      currencyRate.add(CurrencyRate.fromJson(item));
    }
    return currencyRate;
  } else {
    return null;
  }
}

import 'dart:convert';

import 'package:countries_app/countries/data/models/country_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String countriesUrl = 'https://restcountries.com/v3.1/all?fields=name,continents,flags';

List<Country> parseCountries(String responseBody) {
  final list = json.decode(responseBody) as List<dynamic>;
  final countries =
      list.map((e) => Country.fromJson(e as Map<String, dynamic>)).toList();
  return countries;
}

Future<List<Country>> fetchCountries() async {
  final response = await http.get(Uri.parse(countriesUrl));

  if (response.statusCode == 200) {
    return compute(parseCountries, response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

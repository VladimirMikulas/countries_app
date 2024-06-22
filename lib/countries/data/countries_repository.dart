import 'package:dio/dio.dart';

import 'api/countries_rest_client.dart';
import 'api/models/country_details_model.dart';

class CountriesRepository {
  final countryFields =
      'name,currencies,capital,languages,latlng,population,timezones,continents,flags';
  final _restClient = CountriesRestClient(Dio());

  Future<List<CountryDetails>> getCountries() =>
      _restClient.getCountries(countryFields);
}

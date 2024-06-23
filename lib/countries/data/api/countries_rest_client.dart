import 'package:countries_app/countries/data/api/models/country_details_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'countries_rest_client.g.dart';

@RestApi(baseUrl: 'https://restcountries.com/v3.1/')
abstract class CountriesRestClient {
  factory CountriesRestClient(Dio dio) = _CountriesRestClient;

  @GET('/all')
  Future<List<CountryDetailsModel>> getCountries(@Query('fields') String fields);

}

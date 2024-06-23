import 'package:countries_app/countries/data/countries_repository.dart';

import 'models/country_details_ui_model.dart';

class GetCountries {
  final CountriesRepository _countriesRepository = CountriesRepository();

  Future<List<CountryDetailsUiModel>> call() async {
    final result = await _countriesRepository.getCountries();
    return List<CountryDetailsUiModel>.from(
      result.map(toCountryDetailsUiModel).toList(),
    );
  }
}

import 'package:countries_app/countries/data/api/models/country_details_model.dart';

import 'coordinates_ui_model.dart';

class CountryDetailsUiModel {
  final String commonName;
  final String officialName;
  final List<String> capital;
  final int population;
  final List<String> continents;
  final List<String> currencies;
  final List<String> languages;
  final CoordinatesModel? coordinates;
  final List<String> timezones;
  final String flag;

  CountryDetailsUiModel({
    required this.commonName,
    required this.officialName,
    required this.capital,
    required this.population,
    required this.continents,
    required this.currencies,
    required this.languages,
    required this.timezones,
    required this.flag,
    this.coordinates,
  });
}

CountryDetailsUiModel toCountryDetailsUiModel(CountryDetailsModel model) {
  return CountryDetailsUiModel(
    commonName: model.name?.common ?? '',
    officialName: model.name?.official ?? '',
    capital: model.capital ?? List.empty(),
    population: model.population ?? -1,
    continents: model.continents ?? List.empty(),
    currencies:
        model.currencies?.entries.map((e) => e.value.name ?? '').toList() ??
            List.empty(),
    languages:
        model.languages?.entries.map((e) => e.value).toList() ?? List.empty(),
    coordinates: getCoordinatesModel(model.latlng),
    timezones: model.timezones ?? List.empty(),
    flag: model.flags?.png ?? '',
  );
}

CoordinatesModel? getCoordinatesModel(List<double>? latLng) {
  if (latLng == null) {
    return null;
  } else {
    return CoordinatesModel(latLng.first, latLng.last);
  }
}

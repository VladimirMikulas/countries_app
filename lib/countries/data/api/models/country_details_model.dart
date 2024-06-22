import 'package:json_annotation/json_annotation.dart';

part 'country_details_model.g.dart';

@JsonSerializable()
class CountryDetails {
  @JsonKey(includeIfNull: false)
  final Name? name;
  final Map<String, Currency>? currencies;
  final List<String>? capital;
  final Map<String, String>? languages;
  final List<double>? latlng;
  final int? population;
  final List<String>? timezones;
  final List<String>? continents;
  final Flags? flags;

  factory CountryDetails.fromJson(Map<String, dynamic> json) =>
      _$CountryDetailsFromJson(json);

  const CountryDetails({
    this.name,
    this.currencies,
    this.capital,
    this.languages,
    this.latlng,
    this.population,
    this.timezones,
    this.continents,
    this.flags,
  });

  Map<String, dynamic> toJson() => _$CountryDetailsToJson(this);
}

@JsonSerializable()
class Name {
  final String? common;
  final String? official;

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  const Name({
    this.common,
    this.official,
  });

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class Currency {
  final String? name;
  final String? symbol;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  const Currency({
    this.name,
    this.symbol,
  });

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class Flags {
  final String? png;
  final String? svg;

  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);

  const Flags({
    this.png,
    this.svg,
  });

  Map<String, dynamic> toJson() => _$FlagsToJson(this);
}

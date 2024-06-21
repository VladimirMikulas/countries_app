class Country {
  Flags? flags;
  Name? name;
  List<String>? continents;

  Country({this.flags, this.name, this.continents});

  Country.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null
        ? Flags.fromJson(json['flags'] as Map<String, dynamic>)
        : null;
    name = json['name'] != null
        ? Name.fromJson(json['name'] as Map<String, dynamic>)
        : null;
    continents = List<String>.from(json['continents'] as List);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['continents'] = continents;
    return data;
  }
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png']?.toString();
    svg = json['svg']?.toString();
    alt = json['alt']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    data['alt'] = alt;
    return data;
  }
}

class Name {
  String? common;
  String? official;

  Name({this.common, this.official});

  Name.fromJson(Map<String?, dynamic> json) {
    common = json['common'] as String;
    official = json['official']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    return data;
  }
}

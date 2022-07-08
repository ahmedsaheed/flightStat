import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<Airport> airport(String departure) async {
  final response = await http.get(
    Uri.parse(
        'https://aerodatabox.p.rapidapi.com/airports/iata/$departure/?rapidapi-key=349a00db28msh2176012c0ef1149p17700cjsn20907c3c5805'),
  );
  try {
    if (response.statusCode == 200) {
      return airportFromJson(response.body);
    } else {
      throw Exception('Failed to get airport');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Airport airportFromJson(String str) => Airport.fromJson(json.decode(str));

String airportToJson(Airport data) => json.encode(data.toJson());

class Airport {
  Airport({
    this.icao,
    this.iata,
    this.shortName,
    this.fullName,
    this.municipalityName,
    this.location,
    this.country,
    this.continent,
    this.timeZone,
    this.urls,
  });

  String? icao;
  String? iata;
  String? shortName;
  String? fullName;
  String? municipalityName;
  Location? location;
  Continent? country;
  Continent? continent;
  String? timeZone;
  Urls? urls;

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        icao: json["icao"],
        iata: json["iata"],
        shortName: json["shortName"],
        fullName: json["fullName"],
        municipalityName: json["municipalityName"],
        location: Location.fromJson(json["location"]),
        country: Continent.fromJson(json["country"]),
        continent: Continent.fromJson(json["continent"]),
        timeZone: json["timeZone"],
        urls: Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "icao": icao,
        "iata": iata,
        "shortName": shortName,
        "fullName": fullName,
        "municipalityName": municipalityName,
        "location": location!.toJson(),
        "country": country!.toJson(),
        "continent": continent!.toJson(),
        "timeZone": timeZone,
        "urls": urls!.toJson(),
      };
}

class Continent {
  Continent({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Location {
  Location({
    this.lat,
    this.lon,
  });

  double? lat;
  double? lon;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Urls {
  Urls({
    this.webSite,
    this.wikipedia,
    this.twitter,
    this.googleMaps,
    this.flightRadar,
  });

  String? webSite;
  String? wikipedia;
  String? twitter;
  String? googleMaps;
  String? flightRadar;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        webSite: json["webSite"],
        wikipedia: json["wikipedia"],
        twitter: json["twitter"],
        googleMaps: json["googleMaps"],
        flightRadar: json["flightRadar"],
      );

  Map<String, dynamic> toJson() => {
        "webSite": webSite,
        "wikipedia": wikipedia,
        "twitter": twitter,
        "googleMaps": googleMaps,
        "flightRadar": flightRadar,
      };
}

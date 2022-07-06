import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sizeConfig.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Flight> fetchFlight(String flightNo, String date) async {
  final response = await http.get(Uri.parse(
      'http://api.aviationstack.com/v1/flights?access_key=f524a0eb3dee967372fbdbe7bbcbeb47'));

//http://api.aviationstack.com/v1/flights?access_key=3a3482cb4d3c99a3bb8e3076e71f7c10&flight_iata=$flightNo&date=$date
  try {
    if (response.statusCode == 200) {
      return flightFromJson(response.body);
    } else {
      throw Exception('Failed to load flights');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Flight flightFromJson(String str) => Flight.fromJson(json.decode(str));

String flightToJson(Flight data) => json.encode(data.toJson());

class Flight {
  Flight({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<FlightData>? data;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<FlightData>.from(
            json["data"].map((x) => FlightData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FlightData {
  FlightData({
    this.flightDate,
    this.flightStatus,
    this.departure,
    this.arrival,
    this.airline,
    this.flight,
    this.aircraft,
    this.live,
  });

  DateTime? flightDate;
  FlightStatus? flightStatus;
  Arrival? departure;
  Arrival? arrival;
  Airline? airline;
  FlightClass? flight;
  Aircraft? aircraft;
  Live? live;

  factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        flightDate: DateTime.parse(json["flight_date"]),
        flightStatus: flightStatusValues.map[json["flight_status"]],
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        airline: Airline.fromJson(json["airline"]),
        flight: FlightClass.fromJson(json["flight"]),
        aircraft: json["aircraft"] == null
            ? null
            : Aircraft.fromJson(json["aircraft"]),
        live: json["live"] == null ? null : Live.fromJson(json["live"]),
      );

  Map<String, dynamic> toJson() => {
        "flight_date":
            "${flightDate!.year.toString().padLeft(4, '0')}-${flightDate!.month.toString().padLeft(2, '0')}-${flightDate!.day.toString().padLeft(2, '0')}",
        "flight_status": flightStatusValues.reverse![flightStatus],
        "departure": departure!.toJson(),
        "arrival": arrival!.toJson(),
        "airline": airline!.toJson(),
        "flight": flight!.toJson(),
        "aircraft": aircraft == null ? null : aircraft!.toJson(),
        "live": live == null ? null : live!.toJson(),
      };
}

class Aircraft {
  Aircraft({
    this.registration,
    this.iata,
    this.icao,
    this.icao24,
  });

  String? registration;
  String? iata;
  String? icao;
  String? icao24;

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        registration: json["registration"],
        iata: json["iata"],
        icao: json["icao"],
        icao24: json["icao24"],
      );

  Map<String, dynamic> toJson() => {
        "registration": registration,
        "iata": iata,
        "icao": icao,
        "icao24": icao24,
      };
}

class Airline {
  Airline({
    this.name,
    this.iata,
    this.icao,
  });

  String? name;
  String? iata;
  String? icao;

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        name: json["name"],
        iata: json["iata"],
        icao: json["icao"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iata": iata,
        "icao": icao,
      };
}

class Arrival {
  Arrival({
    this.airport,
    this.timezone,
    this.iata,
    this.icao,
    this.terminal,
    this.gate,
    this.baggage,
    this.delay,
    this.scheduled,
    this.estimated,
    this.actual,
    this.estimatedRunway,
    this.actualRunway,
  });

  String? airport;
  String? timezone;
  String? iata;
  String? icao;
  String? terminal;
  String? gate;
  String? baggage;
  int? delay;
  DateTime? scheduled;
  DateTime? estimated;
  DateTime? actual;
  DateTime? estimatedRunway;
  DateTime? actualRunway;

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        airport: json["airport"],
        timezone: json["timezone"],
        iata: json["iata"],
        icao: json["icao"],
        terminal: json["terminal"] == null ? null : json["terminal"],
        gate: json["gate"] == null ? null : json["gate"],
        baggage: json["baggage"] == null ? null : json["baggage"],
        delay: json["delay"] == null ? null : json["delay"],
        scheduled: DateTime.parse(json["scheduled"]),
        estimated: DateTime.parse(json["estimated"]),
        actual: json["actual"] == null ? null : DateTime.parse(json["actual"]),
        estimatedRunway: json["estimated_runway"] == null
            ? null
            : DateTime.parse(json["estimated_runway"]),
        actualRunway: json["actual_runway"] == null
            ? null
            : DateTime.parse(json["actual_runway"]),
      );

  Map<String, dynamic> toJson() => {
        "airport": airport,
        "timezone": timezone,
        "iata": iata,
        "icao": icao,
        "terminal": terminal == null ? null : terminal,
        "gate": gate == null ? null : gate,
        "baggage": baggage == null ? null : baggage,
        "delay": delay == null ? null : delay,
        "scheduled": scheduled!.toIso8601String(),
        "estimated": estimated!.toIso8601String(),
        "actual": actual == null ? null : actual!.toIso8601String(),
        "estimated_runway":
            estimatedRunway == null ? null : estimatedRunway!.toIso8601String(),
        "actual_runway":
            actualRunway == null ? null : actualRunway!.toIso8601String(),
      };
}

class FlightClass {
  FlightClass({
    this.number,
    this.iata,
    this.icao,
    this.codeshared,
  });

  String? number;
  String? iata;
  String? icao;
  Codeshared? codeshared;

  factory FlightClass.fromJson(Map<String, dynamic> json) => FlightClass(
        number: json["number"],
        iata: json["iata"],
        icao: json["icao"],
        codeshared: json["codeshared"] == null
            ? null
            : Codeshared.fromJson(json["codeshared"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "iata": iata,
        "icao": icao,
        "codeshared": codeshared == null ? null : codeshared!.toJson(),
      };
}

class Codeshared {
  Codeshared({
    this.airlineName,
    this.airlineIata,
    this.airlineIcao,
    this.flightNumber,
    this.flightIata,
    this.flightIcao,
  });

  String? airlineName;
  String? airlineIata;
  String? airlineIcao;
  String? flightNumber;
  String? flightIata;
  String? flightIcao;

  factory Codeshared.fromJson(Map<String, dynamic> json) => Codeshared(
        airlineName: json["airline_name"],
        airlineIata: json["airline_iata"],
        airlineIcao: json["airline_icao"],
        flightNumber: json["flight_number"],
        flightIata: json["flight_iata"],
        flightIcao: json["flight_icao"],
      );

  Map<String, dynamic> toJson() => {
        "airline_name": airlineName,
        "airline_iata": airlineIata,
        "airline_icao": airlineIcao,
        "flight_number": flightNumber,
        "flight_iata": flightIata,
        "flight_icao": flightIcao,
      };
}

enum FlightStatus { SCHEDULED, CANCELLED, ACTIVE, LANDED }

final flightStatusValues = EnumValues({
  "active": FlightStatus.ACTIVE,
  "cancelled": FlightStatus.CANCELLED,
  "landed": FlightStatus.LANDED,
  "scheduled": FlightStatus.SCHEDULED
});

class Live {
  Live({
    this.updated,
    this.latitude,
    this.longitude,
    this.altitude,
    this.direction,
    this.speedHorizontal,
    this.speedVertical,
    this.isGround,
  });

  DateTime? updated;
  double? latitude;
  double? longitude;
  double? altitude;
  int? direction;
  double? speedHorizontal;
  int? speedVertical;
  bool? isGround;

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        updated: DateTime.parse(json["updated"]),
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        altitude: json["altitude"].toDouble(),
        direction: json["direction"],
        speedHorizontal: json["speed_horizontal"].toDouble(),
        speedVertical: json["speed_vertical"],
        isGround: json["is_ground"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated!.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "direction": direction,
        "speed_horizontal": speedHorizontal,
        "speed_vertical": speedVertical,
        "is_ground": isGround,
      };
}

class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int? limit;
  int? offset;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "total": total,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

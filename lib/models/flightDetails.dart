import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../sizeConfig.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Flight> fetchFlight(String flightNo, String date) async {
  final response = await http.get(Uri.parse(
      'http://api.aviationstack.com/v1/flights?access_key=3a3482cb4d3c99a3bb8e3076e71f7c10&flight_iata=$flightNo&date=$date'));

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
    required this.pagination,
    required this.data,
  });

  Pagination pagination;
  List<FlightData> data;

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<FlightData>.from(
            json["data"].map((x) => FlightData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FlightData {
  FlightData({
    required this.flightDate,
    required this.flightStatus,
    required this.departure,
    required this.arrival,
    required this.airline,
    required this.flight,
    required this.aircraft,
    required this.live,
  });

  DateTime? flightDate;
  String? flightStatus;
  Arrival? departure;
  Arrival? arrival;
  Airline? airline;
  FlightClass? flight;
  Aircraft? aircraft;
  dynamic live;

  factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        flightDate: DateTime.parse(json["flight_date"]),
        flightStatus: json["flight_status"],
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        airline: Airline.fromJson(json["airline"]),
        flight: FlightClass.fromJson(json["flight"]),
        aircraft: json["aircraft"] == null
            ? null
            : Aircraft.fromJson(json["aircraft"]),
        live: json["live"],
      );

  Map<String, dynamic> toJson() => {
        "flight_date":
            "${flightDate!.year.toString().padLeft(4, '0')}-${flightDate!.month.toString().padLeft(2, '0')}-${flightDate!.day.toString().padLeft(2, '0')}",
        "flight_status": flightStatus,
        "departure": departure!.toJson(),
        "arrival": arrival!.toJson(),
        "airline": airline!.toJson(),
        "flight": flight!.toJson(),
        "aircraft": aircraft == null ? null : aircraft!.toJson(),
        "live": live,
      };
}

class Aircraft {
  Aircraft({
    required this.registration,
    required this.iata,
    required this.icao,
    required this.icao24,
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
    required this.name,
    required this.iata,
    required this.icao,
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
    required this.airport,
    required this.timezone,
    required this.iata,
    required this.icao,
    required this.terminal,
    required this.gate,
    required this.baggage,
    required this.delay,
    required this.scheduled,
    required this.estimated,
    this.actual,
    required this.estimatedRunway,
    required this.actualRunway,
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
        actual: json["actual"] == null
            ? null
            : DateTime.parse(json["actual"]) as DateTime,
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
    required this.number,
    required this.iata,
    required this.icao,
    required this.codeshared,
  });

  String? number;
  String? iata;
  String? icao;
  dynamic codeshared;

  factory FlightClass.fromJson(Map<String, dynamic> json) => FlightClass(
        number: json["number"],
        iata: json["iata"],
        icao: json["icao"],
        codeshared: json["codeshared"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "iata": iata,
        "icao": icao,
        "codeshared": codeshared,
      };
}

class Pagination {
  Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
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

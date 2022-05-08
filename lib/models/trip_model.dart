import 'package:bloc/bloc.dart';

class TripModel {
  late String startPoint;
  late String endPoint;
  late String time;
  late String date;
  late String driverName;
  late String driverPhone;
  late String currentStation;
  late String uId;
  TripModel(
      {required this.startPoint,
      required this.endPoint,
      required this.time,
      required this.date,
      required this.driverName,
      required this.driverPhone,
      currentStation = 'Starting Point',
      required this.uId});

  TripModel.fromJson(Map<String, dynamic> json) {
    startPoint = json['startPoint'];
    endPoint = json['endPoint'];
    time = json['time'];
    date = json['date'];
    currentStation = json['currentStation'];

    uId = json['uId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'startPoint': startPoint,
      'endPoint': endPoint,
      'time': time,
      'uId': uId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'date': date,
      'currentStation': 'Al-Shrouk'
    };
  }
}

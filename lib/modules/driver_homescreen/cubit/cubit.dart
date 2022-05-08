import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/models/trip_model.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/states.dart';
import 'package:wasalny/modules/home_screen/home_screen.dart';
import 'package:wasalny/modules/settings_screen/settings_screen.dart';
import 'package:wasalny/modules/trips_screen/trips_screen.dart';
import 'package:wasalny/modules/your_trips_screen/your_trips_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverHomeScreenCubit extends Cubit<DriverHomeScreenStates> {
  DriverHomeScreenCubit() : super(DriverHomeScreenInitialState());
  static DriverHomeScreenCubit get(context) => BlocProvider.of(context);
  bool hidePassword = true;
  late TripModel model;
  var auth = FirebaseAuth.instance;

  String driverName = 'none';
  String driverPhone = '0';
  String Currentplace = '';

  int currentStation = 0;
  final List<String> stations = [
    'Al-Shorouk',
    'AL-Mostakbal City',
    'Al-Obour City',
    'Al-Salam',
    'Nasr City',
  ];

  void changeToNextStationStation(String tripUid) {
    if (currentStation < stations.length - 1 && currentStation >= 0) {
      currentStation++;
      FirebaseFirestore.instance.collection('trips').doc('$tripUid').update(
          {'currentStation': '${stations[currentStation]}'}).then((value) {
        print(Currentplace);
        getactualPlace(tripUid);
        emit(ChangeNextStationState());
      });
    } else {
      currentStation < stations.length - 1
          ? currentStation++
          : print(currentStation);
      emit(ChangePreviousStationState());
    }
  }

  void changeToPreviousStation(String tripUid) {
    if (currentStation > 0 && currentStation < stations.length) {
      --currentStation;
      FirebaseFirestore.instance.collection('trips').doc('$tripUid').update(
          {'currentStation': '${stations[currentStation]}'}).then((value) {
        getactualPlace(tripUid);
        print(Currentplace);
        emit(ChangePreviousStationState());
      });
    } else {
      currentStation > 0 ? currentStation-- : print(currentStation);
      emit(ChangePreviousStationState());
    }
  }
  // void changeToMyPreviousStation(String tripUid) {
  //   if (currentStation > 0 && currentStation < stations.length) {
  //     --currentStation;
  //     FirebaseFirestore.instance.collection('users').doc('$tripUid').update(
  //         {'currentStation': '${stations[currentStation]}'}).then((value) {
  //       getactualPlace(tripUid);
  //       print(Currentplace);
  //       emit(ChangePreviousStationState());
  //     });
  //   } else {
  //     currentStation > 0 ? currentStation-- : print(currentStation);
  //     emit(ChangePreviousStationState());
  //   }
  // }

  // void setCurrentStation(String tripUid) {
  //   getactualPlace(tripUid);
  //   emit(GetCurrentStationState());
  // }
  //
  void getactualPlace(String tripUid) {
    FirebaseFirestore.instance
        .collection('trips')
        .doc('$tripUid')
        .get()
        .then((value) {
      Currentplace = value.data()!['currentStation'];
      currentStation = stations.indexOf('$Currentplace');
      print(Currentplace);
      emit(GetCurrentStationState());
    });
  }

  // void getMyactualPlace(String tripUid) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${auth.currentUser!.uid}').collection('userTrips').doc('$tripUid')
  //       .get()
  //       .then((value) {
  //     Currentplace = value.data()!['currentStation'];
  //     currentStation = stations.indexOf('$Currentplace');
  //     print(Currentplace);
  //     emit(GetCurrentStationState());
  //   });
  // }
  void endTrip(String Uid, var context) {
    FirebaseFirestore.instance
        .collection('trips')
        .doc('$Uid')
        .delete()
        .then((value) => Navigator.pop(context));
  }

  void signOut(var context) {
    auth.signOut().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }
  // void changeStep(int value) {
  //   currentStep = value;
  //   emit(ChangeActiveStepState());
  // }

  int currentIndex = 1;

  void reset() {
    emit(DriverHomeScreenInitialState());
  }

  List<BottomNavigationBarItem> boottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Your Trips'),
    BottomNavigationBarItem(
        icon: Icon(Icons.directions_bus_rounded), label: 'Trips'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> screens = [YourTripsScreen(), TripsScreen(), SettingsScreen()];

  void BottomNavChang(int index) {
    currentIndex = index;
    emit(DriverHomeScreenBotNavState());
  }

  List<String> startPointPlaces = ['Al-Shrouk'];
  List<String> endPointPlaces = ['Nasr City', 'Al-Abbasya', 'Saraya El-Qubba'];
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
  void createTrip(
      {required String startPoint,
      required String endPoint,
      required String time,
      required String date,
      required String driverName,
      required String phoneNumber,
      String currentStation = 'StartPoint',
      required var context}) {
    TripModel model = TripModel(
        startPoint: startPoint,
        endPoint: endPoint,
        time: time,
        date: date,
        driverName: driverName,
        driverPhone: driverPhone,
        currentStation: 'Start Point',
        uId: auth.currentUser!.uid);
    FirebaseFirestore.instance
        .collection('trips')
        .doc()
        .set(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('userTrips')
          .doc()
          .set(model.toMap());
      Navigator.pop(context);
      emit(CreateTripSuccessState());
    }).catchError((e) {
      emit(CreateTripErrorState());
    });
  }

  List<dynamic> trips = [];

  void tripsStream() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('trips').snapshots()) {
      for (var trip in snapshot.docs) {
        print(trip.data());
      }
    }
  }

  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser!.uid}')
        .get()
        .then((value) {
      driverName = value.data()!['name'];
      driverPhone = value.data()!['phone'];
    });
  }
  // void getTripInfo()
  //   emit(GetTripLoadingState());
  //   FirebaseFirestore.instance.collection('trips').get().then((value) {
  //     for (var trip in value.docs) {
  //       print(trip.data());
  //     }
  //     trips.clear();
  //     print(trips);
  //     emit(GetTripSuccessState());
  //   });
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/cubit.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/states.dart';
import 'package:wasalny/modules/trip_monitoring_screen/trip_monitoring_screen.dart';
import 'package:wasalny/modules/user_monitoring_screen/user_monitoring_screen.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

class TripsScreen extends StatelessWidget {
  var startPointController = TextEditingController();
  var endPointController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var value;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DriverHomeScreenCubit()..getUserData(),
      child: BlocConsumer<DriverHomeScreenCubit, DriverHomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DriverHomeScreenCubit cubit = DriverHomeScreenCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Trips'),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: kMainColor,
                onPressed: () {
                  cubit.tripsStream();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Form(
                          key: formKey,
                          child: Dialog(
                            insetPadding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 130),
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Add your trip details',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.green, width: 2)),
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return ('Start point must be not empty');
                                          } else if (value != null) {
                                            return null;
                                          }
                                        },
                                        isExpanded: true,
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        ),
                                        dropdownColor: Colors.white,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.green,
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text('Start point'),
                                        ),
                                        value: value,
                                        items: cubit.startPointPlaces
                                            .map(cubit.buildMenuItem)
                                            .toList(),
                                        onChanged: (value) {
                                          startPointController.text =
                                              value.toString();
                                          value = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.red, width: 2)),
                                      child: DropdownButtonFormField(
                                        validator: (value) {
                                          if (value == null) {
                                            return ('Start point must be not empty');
                                          } else if (value != null) {
                                            return null;
                                          }
                                        },
                                        isExpanded: true,
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        dropdownColor: Colors.white,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.red,
                                        ),
                                        hint: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text('End point'),
                                        ),
                                        value: value,
                                        items: cubit.endPointPlaces
                                            .map(cubit.buildMenuItem)
                                            .toList(),
                                        onChanged: (value) {
                                          endPointController.text =
                                              value.toString();
                                          value = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: defaultTextForm(
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) =>
                                                  timeController.text = value!
                                                      .format(context)
                                                      .toString());
                                        },
                                        controller: timeController,
                                        label: 'Time',
                                        color: kSecColor,
                                        keyboardtype: TextInputType.none,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ('time must be not empty');
                                          } else if (value.isNotEmpty) {
                                            return null;
                                          }
                                        },
                                        icon: Icons.access_time,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: defaultTextForm(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2025))
                                              .then((value) {
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        controller: dateController,
                                        label: 'date',
                                        color: kSecColor,
                                        keyboardtype: TextInputType.none,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ('date must be not empty');
                                          } else if (value.isNotEmpty) {
                                            return null;
                                          }
                                        },
                                        icon: Icons.calendar_today,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    defaultButton(
                                        color: kMainColor,
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.createTrip(
                                                startPoint:
                                                    startPointController.text,
                                                endPoint:
                                                    endPointController.text,
                                                time: timeController.text,
                                                date: dateController.text,
                                                driverName: cubit.driverName,
                                                phoneNumber: cubit.driverPhone,
                                                context: context);
                                            print(
                                                '${startPointController.text}+gamed');
                                            timeController.clear();
                                            dateController.clear();
                                            startPointController.clear();
                                            endPointController.clear();
                                          }
                                        },
                                        text: 'Add Trip')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Icon(
                  Icons.add,
                )),
            body: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('trips').snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> tripWidgets = [];
                      if (snapshot.hasData) {
                        final trips = snapshot.data!.docs;

                        for (var trip in trips) {
                          final tripStartPoint = trip.data()['startPoint'];
                          final tripEndPoint = trip.data()['endPoint'];
                          final tripTime = trip.data()['time'];
                          final tripDate = trip.data()['date'];
                          final tripDriver = trip.data()['driverName'];
                          final tripPhone = trip.data()['driverPhone'];
                          final tripCurrentStation =
                              trip.data()['currentStation'];
                          final tripUid = trip.id;
                          final tripWidget = tripCard(
                              startPoint: tripStartPoint,
                              endPoint: tripEndPoint,
                              time: tripTime,
                              date: tripDate,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Form(
                                        key: formKey,
                                        child: Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 130),
                                          elevation: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SingleChildScrollView(
                                              physics: BouncingScrollPhysics(),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    minRadius: 50,
                                                    child: Icon(
                                                      Icons
                                                          .directions_bus_rounded,
                                                      color: Colors.white,
                                                      size: 50,
                                                    ),
                                                    backgroundColor: kMainColor,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.person_pin,
                                                        color: Colors.black,
                                                        size: 40,
                                                      ),
                                                      Text(
                                                        '$tripDriver',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.call,
                                                        color: Colors.blue,
                                                        size: 30,
                                                      ),
                                                      Text(
                                                        '+2$tripPhone',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.green,
                                                      ),
                                                      Text(
                                                        '$tripStartPoint',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: arrow(
                                                          color: Colors.black)),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        '$tripEndPoint',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 25),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .watch_later_outlined,
                                                            color: kMainColor,
                                                          ),
                                                          Text(
                                                            '$tripTime',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 25),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color: Colors.brown,
                                                          ),
                                                          Text(
                                                            '$tripDate',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 25),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  defaultButton(
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        print(
                                                            tripCurrentStation);
                                                        cubit.Currentplace =
                                                            tripCurrentStation;

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        UserMonitoringScreen(
                                                                          tripUid:
                                                                              tripUid,
                                                                          startPoint:
                                                                              tripStartPoint,
                                                                          endPoint:
                                                                              tripEndPoint,
                                                                          driverName:
                                                                              tripDriver,
                                                                          tripPhone:
                                                                              tripPhone,
                                                                        )));
                                                      },
                                                      text: 'Monitor')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              });
                          tripWidgets.add(tripWidget);
                        }
                      }
                      return Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          physics: BouncingScrollPhysics(),
                          children: tripWidgets,
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}

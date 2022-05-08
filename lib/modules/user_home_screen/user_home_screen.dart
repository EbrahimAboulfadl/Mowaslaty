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

class UserHomeScreen extends StatelessWidget {
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
      create: (BuildContext context) => DriverHomeScreenCubit(),
      child: BlocConsumer<DriverHomeScreenCubit, DriverHomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DriverHomeScreenCubit cubit = DriverHomeScreenCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Trips'),
            ),
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

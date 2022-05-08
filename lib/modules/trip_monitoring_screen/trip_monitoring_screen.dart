import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/cubit.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/states.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripMonitoringScreen extends StatelessWidget {
  String startPoint;
  String tripPhone;
  String endPoint;
  String driverName;
  String tripUid;
  // String currentStation;

  TripMonitoringScreen(
      {required this.startPoint,
      required this.endPoint,
      required this.tripUid,
      required this.driverName,
      required this.tripPhone
      // required this.currentStation
      });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          DriverHomeScreenCubit()..getactualPlace(tripUid),
      child: BlocConsumer<DriverHomeScreenCubit, DriverHomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DriverHomeScreenCubit cubit = DriverHomeScreenCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('$startPoint to $endPoint'),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Timeline.tileBuilder(
                        physics: BouncingScrollPhysics(),
                        theme: TimelineThemeData(color: kSecColor),
                        builder: TimelineTileBuilder.fromStyle(
                          connectorStyle: ConnectorStyle.dashedLine,
                          indicatorStyle: IndicatorStyle.dot,
                          itemCount: cubit.stations.length,
                          contentsAlign: ContentsAlign.alternating,
                          contentsBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text('${cubit.stations[index]}')),
                                  CircleAvatar(
                                    backgroundColor: cubit.stations[index] ==
                                            cubit.Currentplace
                                        ? Colors.green
                                        : Colors.white,
                                    child: Icon(
                                      Icons.directions_bus_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 35,
                    ),
                    Text(
                      '$driverName',
                      style: TextStyle(fontSize: 25),
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
                      '$startPoint',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
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
                      color: Colors.red,
                    ),
                    Text(
                      '$endPoint',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.call,
                      color: Colors.blue,
                      size: 30,
                    ),
                    Text(
                      '+2$tripPhone',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: defaultButton(
                            color: Colors.green,
                            onPressed: () {
                              cubit.changeToNextStationStation(tripUid);
                            },
                            text: 'Next Station')),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: defaultButton(
                            color: Colors.red,
                            onPressed: () {
                              cubit.changeToPreviousStation(tripUid);
                            },
                            text: 'Previous Station'))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                defaultButton(
                    onPressed: () {
                      cubit.endTrip(tripUid, context);
                    },
                    text: 'End Trip',
                    color: Colors.black)
              ],
            ),
          );
        },
      ),
    );
  }
}
// IconStepper(
// steppingEnabled: true,
// icons: [
// Icon(
// Icons.pin_drop,
// color: Colors.white,
// semanticLabel: 'gamed',
// ),
// Icon(
// Icons.pin_drop,
// color: Colors.white,
// ),
// Icon(
// Icons.pin_drop,
// color: Colors.white,
// ),
// ],
// stepColor: Colors.orange,
// activeStepColor: kSecColor,
// direction: Axis.vertical,
// activeStep: cubit.currentStep,
// onStepReached: (value) {
// cubit.changeStep(value);
// },
// ),

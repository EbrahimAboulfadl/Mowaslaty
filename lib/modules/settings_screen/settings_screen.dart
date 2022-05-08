import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/cubit.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/states.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              title: Text('Settings'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultButton(
                    onPressed: () {
                      cubit.signOut(context);
                    },
                    text: 'Log Out',
                    color: kMainColor)
              ],
            ),
          );
        },
      ),
    );
  }
}

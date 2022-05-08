import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/cubit.dart';
import 'package:wasalny/modules/driver_homescreen/cubit/states.dart';

class DriverHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DriverHomeScreenCubit(),
      child: BlocConsumer<DriverHomeScreenCubit, DriverHomeScreenStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DriverHomeScreenCubit cubit = DriverHomeScreenCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.BottomNavChang(index);
              },
              items: cubit.boottomItems,
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}

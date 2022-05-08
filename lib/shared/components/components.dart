import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

Widget defaultButton(
        {double width = 200,
        Color color = Colors.pinkAccent,
        required VoidCallback onPressed,
        required String text,
        double height = 50,
        bool upperCase = true}) =>
    Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(25)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            upperCase ? text : text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
Widget defaultTextForm(
        {required TextEditingController controller,
        required String label,
        double height = 1,
        required TextInputType keyboardtype,
        required String? Function(String?) validator,
        required IconData icon,
        Color color = Colors.black,
        bool isPassword = false,
        bool isClickable = true,
        VoidCallback? onTap,
        IconData? suffixIcon,
        VoidCallback? suffixOnTap}) =>
    TextFormField(
      cursorColor: color,
      validator: validator,
      controller: controller,
      keyboardType: keyboardtype,
      obscureText: isPassword,
      onTap: onTap,
      enabled: isClickable,
      style: TextStyle(fontSize: 14, height: height),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
        floatingLabelStyle: TextStyle(color: color),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: BorderSide(color: color, width: 2)),
        focusColor: color,
        labelText: label,
        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: color, width: 2)),
        suffixIcon: GestureDetector(
            onTap: suffixOnTap,
            child: Icon(
              suffixIcon,
              color: color,
            )),
        prefixIcon: Icon(
          icon,
          color: color,
        ),
      ),
      onFieldSubmitted: (value) {},
      onChanged: (value) {},
    );
Widget txt() {
  return TextFormField();
}

Widget tripCard(
    {required String startPoint,
    required String endPoint,
    required String time,
    required VoidCallback onTap,
    required String date}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: 140,
          decoration: BoxDecoration(
              border: Border.all(color: kMainColor),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 30,
                child: Icon(
                  Icons.directions_bus_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                backgroundColor: kMainColor,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        Text(
                          '$startPoint',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          '$endPoint',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$time',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$date',
                    style: TextStyle(color: Colors.black54),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    ),
  );
}

Widget arrow({color = Colors.red}) {
  return Column(
    children: [
      Container(
        height: 5,
        width: 3,
        color: color,
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        height: 5,
        width: 3,
        color: color,
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        height: 5,
        width: 3,
        color: color,
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        height: 5,
        width: 3,
        color: color,
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        height: 5,
        width: 3,
        color: color,
      ),
      SizedBox(
        height: 2,
      ),
    ],
  );
}

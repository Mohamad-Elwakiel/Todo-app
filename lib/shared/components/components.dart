// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget defaultButton ({
  required VoidCallback function,
  required String text,
  double width  = double.infinity,
  Color color = Colors.blue,
  double radius = 10.0,
  bool isUpperCase = true,
}) => Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius)
  ),
  child: MaterialButton(
    onPressed: function,
    child: Text(
    isUpperCase ? text.toUpperCase() : text,
    style: TextStyle(
      color: Colors.white,
    ),
    ),
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType inputType,
  Function(String?)?  onSubmit,
  Function(String?)? onChange,
  VoidCallback? onTap,
  required String? Function(String?)? validator,
  required String text,
  required IconData prefixIcon,
   IconData? suffixIcon,
  bool isClickable = true,
  VoidCallback? suffixPressed,
  bool isPassword = false,
}) =>  TextFormField(
  controller: controller,
  keyboardType: inputType,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  enabled: isClickable,
  validator: validator,
  onTap: onTap,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefixIcon,
    ),
    suffixIcon: suffixIcon!=null? IconButton(
      icon: Icon(suffixIcon),
      onPressed: suffixPressed,
    ) :  null,
  ),
);

Widget buildTaskItem(Map model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children:
    [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.blueGrey,
        child: Text(
            '${model['time']}',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model['tittle']}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${model['date']}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 20,
      ),
      IconButton(
          onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
          icon: Icon(
            Icons.check_circle_outline
          ),),
      IconButton(
        onPressed: ()
        {
          AppCubit.get(context).updateData(status: 'Archived', id: model['id']);
        },
        icon: Icon(
            Icons.archive_outlined
        ),),
    ],
  ),
);
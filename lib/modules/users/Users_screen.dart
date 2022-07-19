// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/user_model/user_model.dart';


// ignore: empty_constructor_bodies
class UserScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'Mohmad Elwakiel', number: '+20 1500 1312 142'),
    UserModel(id: 2, name: 'Ahemd hassan', number: '+20 1500 1312 142'),
    UserModel(id: 3, name: 'Hossam Hassan', number: '+20 1500 1312 142'),
    UserModel(id: 4, name: 'Zoba Noba', number: '+20 1500 1312 142'),
    UserModel(id: 5, name: 'Harry Peniro', number: '+20 1500 1312 142'),
    UserModel(id: 6, name: 'Shekora Chunky', number: '+20 1500 1312 142'),
    UserModel(id: 7, name: 'Hatey Batey', number: '+20 1500 1312 142'),
    UserModel(id: 8, name: 'Trippy Briddy', number: '+20 1500 1312 142'),
    UserModel(id: 9, name: 'Flubky Bunky', number: '+20 1500 1312 142'),
    UserModel(id: 10, name: 'Chunky Lunky ', number: '+20 1500 1312 142'),
    UserModel(id: 11, name: 'Zeko Sheko ', number: '+20 1500 1312 142'),
    UserModel(id: 12, name: 'Feko Neko', number: '+20 1500 1312 142'),



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users'
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
          ),
          itemCount: users.length),
    );

  }
  Widget buildUserItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 15,
          child: Text(
            '${user.id}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              user.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${user.number}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import 'dart:io';


/// save image on cache using shared_preferences throw image's path

File? imgFile;
String? imgPath;

class Notedetails extends StatefulWidget {
  final dynamic todo;

  const Notedetails({Key? key, this.todo}) : super(key: key);

  @override
  State<Notedetails> createState() => _NotedetailsState();
}

class _NotedetailsState extends State<Notedetails> {
  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("POST-it NOTE",
            style: TextStyle(
                fontFamily: "Oranienbaum",
                fontSize: 27,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 30),
            Column(
              children: [
                columnTitle(
                  "Title",
                  widget.todo['first_name'],
                ),
                columnDescription("Description", widget.todo["last_name"])
              ],
            ),
          ],
        ));
  }

  Widget columnTitle(String title, dynamic value) {
    return Column(

      children: [
        const SizedBox(height: 1),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 40,
            fontFamily: "Oranienbaum",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget columnDescription(String description, dynamic value) {
    return Column(

      children: [
        const SizedBox(height: 50),
        Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "Oranienbaum",
            ),
          ),
        )
      ],
    );
  }
}
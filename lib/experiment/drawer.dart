import 'dart:convert';

import 'package:frontend_diaryapp/experiment/infopage.dart';
import 'package:frontend_diaryapp/models/user.dart';
import 'package:frontend_diaryapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.yellow,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 50),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/zerl.jpg'),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("Angelica Zerl Lazarito",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Oranienbaum",
                            fontWeight: FontWeight.bold,
                            color: Colors.black)
                    ),
                    const SizedBox(height: 5),

                    const Text("zerl@gmail.com",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Oranienbaum",
                            //fontWeight: FontWeight.bold,
                            color: Colors.black)
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.edit_note_outlined, size: 22,
                  color: Colors.black87),
              title: const Text('Notes',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Oranienbaum",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.settings_rounded, size: 22,
                  color: Colors.black87),
              title: const Text('Information',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Oranienbaum",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  ProfileHelp())
                );
              },
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: const Icon(Icons.logout_rounded,
                  size: 22,
                  color: Colors.black87),
              title: const Text('Logout',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Oranienbaum",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)
              ),
              onTap: (){
                logoutNow().then((value) =>
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>const LoginScreen())));
              },
            ),
    ]));
  }


}

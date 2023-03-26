import 'dart:convert';
import 'package:frontend_diaryapp/experiment/note_details.dart';
import 'package:frontend_diaryapp/models/user.dart';
import 'package:frontend_diaryapp/experiment/drawer.dart';
import 'package:frontend_diaryapp/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend_diaryapp/experiment/addnote.dart';
import 'package:frontend_diaryapp/services/global.dart';

class HomeData extends StatefulWidget {
  const HomeData({ Key? key }) : super(key: key);

  @override
  _HomeDataState createState() => _HomeDataState();
}

class _HomeDataState extends State<HomeData> {
  List allData = <dynamic>[];
  int user_id = 0;
  bool isLoading = true;


  Future getData()async{
    String token = await getToken();
    user_id = await getUserId();
    var headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    };
    final uri = Uri.parse('$getEmployeeURL/$user_id');
    final response = await http.get(uri,headers: headers);
    var data = jsonDecode(response.body) as Map;
    var tentative = data['data'] as List;
    print(response.body);
    setState(() {
      allData = tentative;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('POST-it NOTE'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            logoutNow().then((value) => Navigator.push(context, MaterialPageRoute(
                builder: (context)=>const LoginScreen())));
          }, icon: const Icon(Icons.logout))
        ],
      ),
        drawer: const MainDrawer(),
        body: Container(
            height: 900,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child:
            Padding(
              padding: const EdgeInsets.all(15.0),
              child:RefreshIndicator(
                onRefresh: getData,
                child: ListView.builder(
                    itemCount: allData.length,
                    itemBuilder: (context,index){
                      var data = allData[index] as Map;
                      var fName = data['first_name'];
                      var lName = data['last_name'];

                      return Card(
                        child: ListTile(
                         leading: CircleAvatar(
                           backgroundColor:
                           index % 2 == 0 ? Colors.yellowAccent : Colors.yellow,
                           foregroundColor: Colors.cyan,
                           child: Text('${index + 1}',
                               style: const TextStyle(
                                 fontSize: 15,
                                   fontFamily: "Oranienbaum",
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black))),

                          title: Text("     "+ fName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "Oranienbaum",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // subtitle: Text(lName),
                        trailing: Column(
                            children: const [
                              SizedBox(height: 5),
                              // Icon(Icons.edit_rounded, color: Colors.green),
                              // Icon(Icons.delete_rounded, color: Colors.red),
                  ]
                ),
                          onTap: (){
                             Navigator.push(
                               context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Notedetails(todo: allData[index]))
                             );
                          },


            ),


            );

          }),
      ),

      )),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: const Text('Add note'
          ),
        )
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => const AddData(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    getData();
  }
}
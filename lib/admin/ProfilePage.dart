import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/backgrounds.dart';

import '../login/LoginHelper.dart';
import 'Departments.dart';

class ProfilePage extends StatelessWidget {
  static String routename = 'profile page';

  //const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Stack(
      children: [
        Background('assets/images/BG1.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: Column(
            children: [
              Expanded(
                  child:
              //     Row(
              //       children: [
              //         SizedBox(width: 20,
              //     ),
              //   ],
              // )
                  Row(
                      children: [SizedBox(width: 20,),
                        FloatingActionButton(onPressed: (){
                          Navigator.pop(context,
                              MaterialPageRoute(builder: (context)=> Departments()));},
                            child: Icon(Icons.arrow_back,color: Colors.black),
                            backgroundColor: Colors.white),
                      ]
                  ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user")
                        .where("uid", isEqualTo: currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      print("Number of documents retrieved: ${snapshot.data?.docs.length}");
                      if (snapshot.hasData) {
                        return Expanded(
                          flex: 2,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                var data = snapshot.data!.docs[i];

                                return Column(
                                  children: [
                                    Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  // SizedBox(
                                                  //   width: 25,
                                                  // ),
                                                  Icon(Icons.person_rounded),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text('Name:',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              206, 185, 151, 1),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(
                                                    width: 18,
                                                  ),
                                                  Text(data['firstname'],
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                  SizedBox(
                                                    width: 18,
                                                  ),
                                                  Text(data['lastname'],
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.black12,
                                                height: 20,
                                                thickness: 1.2,
                                                indent: 75,
                                                endIndent: 30,
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  // SizedBox(
                                                  //   width: 25,
                                                  // ),
                                                  Icon(Icons.email),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text('Email:',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              206, 185, 151, 1),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      data['email'],
                                                      style:
                                                      TextStyle(fontSize: 15),
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.black12,
                                                height: 20,
                                                thickness: 1.2,
                                                indent: 75,
                                                endIndent: 30,
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  Icon(Icons.phone),
                                                  SizedBox(width: 15),
                                                  Text('Phone:',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              206, 185, 151, 1),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(width: 18),
                                                  Text(data['phone'],
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.black12,
                                                height: 20,
                                                thickness: 1.2,
                                                indent: 75,
                                                endIndent: 30,
                                              ),
                                              SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  Icon(Icons.desktop_mac),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text('Department:',
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              206, 185, 151, 1),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(width: 18),
                                                  Text(data['department'],
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ],
                                              ),
                                              const Divider(
                                                color: Colors.black12,
                                                height: 20,
                                                thickness: 1.2,
                                                indent: 75,
                                                endIndent: 30,
                                              ),
                                            ],
                                          )
                                        ]),
                                  ],
                                );
                              }),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          {showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  title: Text(""),
                                  content: Text(" Are you sure want to Logout? "),
                                  actions: [
                                    TextButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        AuthService authservice = AuthService();
                                        authservice.logoutUser(context);
                                      },
                                    ),

                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Color.fromRGBO(196, 25, 14, 1.0),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

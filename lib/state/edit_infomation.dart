import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deargiffarine/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditInformation extends StatefulWidget {
  @override
  _EditInformationState createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  UserModel userModel;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUser();
  }

  Future<Null> readUser() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        print('uid Losing Edit ==>> $uid');

        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .snapshots()
            .listen((event) {
          setState(() {
            userModel = UserModel.fromMap(event.data());
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: null,
      //   child: Icon(Icons.cloud_upload),
      // ),
      appBar: AppBar(
        title: Text('Edit Information'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                buildImage(context),
                buildDisplayName(context),
              ],
            ),
          ),
          buildElevatedButton()
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       buildImage(context),
      //       buildDisplayName(context),
      //     ],
      //   ),
      // ),
    );
  }

  Column buildElevatedButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton.icon(
            onPressed: () {
              print('name = $name');
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('Update Information'),
          ),
        ),
      ],
    );
  }

  Container buildDisplayName(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: MediaQuery.of(context).size.width - 100,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        controller: TextEditingController(text: name == null ? userModel.name : name ),
        decoration: InputDecoration(
          labelText: 'Display Name :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Padding buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 48,
                color: Colors.teal.shade800,
              ),
              onPressed: () {}),
          Container(
            width: MediaQuery.of(context).size.width - 200,
            height: MediaQuery.of(context).size.width - 200,
            child: Image.asset('images/avatar.png'),
          ),
          IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                size: 48,
                color: Colors.teal.shade800,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deargiffarine/models/user_model.dart';
import 'package:deargiffarine/state/edit_infomation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  UserModel userModel;

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
        print('uid Losing ==>> $uid');

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
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                buildImage(context),
                buildUser(),
                buildEmail(),
                buildMap(context)
              ],
            ),
          )
        ],
      ),
      // userModel == null
      //   ? Center(child: CircularProgressIndicator())
      //   : Text('Name : ${userModel.name}'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditInformation(),
            )),
        child: Icon(Icons.edit),
      ),
    );
  }

  Set<Marker> myset() {
    return <Marker>[
      Marker(
        markerId: MarkerId(userModel.name),
        position: LatLng(double.parse(userModel.lat), double.parse(userModel.lng)),
        infoWindow: InfoWindow(
          title: 'คุณอยู่ที่นี่',
          snippet: 'lat = ${userModel.lat}, lng = ${userModel.lng}',
        )
      ),
    ].toSet();
  }

  Expanded buildMap(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 64),
        width: MediaQuery.of(context).size.width,
        child: userModel == null
            ? Text('This is Map')
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(userModel.lat),
                    double.parse(userModel.lng),
                  ),
                  zoom: 16,
                ),
                mapType: MapType.normal,
                onMapCreated: (controller) {},
                markers: myset(),
              ),
      ),
    );
  }

  Text buildEmail() => Text(
        'Email : ${userModel.email}',
        style: GoogleFonts.workSans(
            textStyle: TextStyle(
          fontSize: 26,
          color: Colors.teal.shade800,
        )),
      );

  Text buildUser() => Text(
        'Name : ${userModel.name}',
        style: GoogleFonts.workSans(
            textStyle: TextStyle(
          fontSize: 26,
          color: Colors.teal.shade800,
        )),
      );

  Container buildImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: MediaQuery.of(context).size.width - 200,
      height: MediaQuery.of(context).size.width - 200,
      child: Image.asset('images/avatar.png'),
    );
  }


}

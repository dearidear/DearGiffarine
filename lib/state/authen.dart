
import 'package:deargiffarine/state/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.0,
            colors: <Color>[Colors.white, Colors.cyan[100]],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildLogo(),
                buildAppName(),
                buildUser(),
                buildPassword(),
                buildLogin(),
                buildTextButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Register(),
          ),
        );
      },
      child: Text('New Register'),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Text buildAppName() => Text(
        'Dear Giffarine',
        style: GoogleFonts.gochiHand(
            textStyle: TextStyle(
          color: Colors.indigo.shade600,
          fontSize: 40,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        )),
      );

  Container buildLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: 120,
      child: Image.asset('images/logo1.png'),
    );
  }
}
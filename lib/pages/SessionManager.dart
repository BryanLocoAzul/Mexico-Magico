import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app_02/pages/login.dart';
import 'package:travel_app_02/estados.dart';
import 'package:travel_app_02/SplashScreen.dart';

class SessionManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoggedInStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return splashscreen();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error al verificar estado de inicio de sesión'),
            ),
          );
        } else {
          if (snapshot.data == true) {
            return estados(); // Usuario ya inició sesión
          } else {
            return Login(); // Usuario no ha iniciado sesión
          }
        }
      },
    );
  }

  Future<bool> _checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');
    return authToken != null;
  }
}

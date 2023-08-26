import 'package:flutter/material.dart';
import 'package:travel_app_02/pages/register.dart';
import 'package:travel_app_02/estados.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  dynamic test;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  Future<void> _checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('auth_token');

    if (authToken != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => estados()),
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoggedInStatus();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/vectores/login.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 95, top: 310),
                child: Text(
                  "Bien",
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(3, 109, 207, 1),
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 175, top: 310),
                child: Text(
                  'venido',
                  style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(249, 113, 15, 1),
                    fontSize: 40,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 90, top: 112),
                child: Image.asset(
                  "assets/logo/logo.jpg",
                  height: 190,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: _emailTextController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextField(
                            controller: _passwordTextController,
                            style: TextStyle(),
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.white70),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.translate(
                                offset: Offset(170, -20),
                                child: Text(
                                  "olvidaste tu contraseña?",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 194, 199, 212),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Iniciar sesion',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: _isLoading ? null : () => _login(context),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(66, 116, 255, 1),
                                shape: BoxShape.circle,
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.orange,
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'No tienes una cuenta?',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff4c505b),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    // Simular una espera de 2 segundos para la validación
    await Future.delayed(Duration(seconds: 2));

    String email = _emailTextController.text.trim();
    String password = _passwordTextController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Faltan campos"),
          content: Text("Por favor, ingresa tu correo y contraseña."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final url = Uri.parse('https://mexicomagicoapi.fly.dev/v1/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      final authToken = responseData['token'];

      final storage = FlutterSecureStorage();
      await storage.write(key: 'auth_token', value: authToken);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Inicio de sesión exitoso"),
          content: Text("¡Bienvenido! Has iniciado sesión correctamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => estados()),
                  (route) => false, // Elimina todas las rutas en la pila
                );
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(
            "Error en el inicio de sesión. Por favor, verifica tu correo y contraseña.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );

      print('Error en el inicio de sesión: ${response.statusCode}');
      print(response.body);
    }

    setState(() {
      _isLoading = false;
    });
  }
}

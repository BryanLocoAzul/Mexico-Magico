import 'package:flutter/material.dart';
import 'package:travel_app_02/pages/home_nav.dart';

class estados extends StatefulWidget {
  const estados({super.key});

  @override
  State<estados> createState() => _estadosState();
}

class _estadosState extends State<estados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromRGBO(3, 109, 207, 1),
                    size: 30,
                  ),
                  Text(
                    'MEXICO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(3, 109, 207, 1),
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'MAGICO',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(249, 113, 15, 1),
                      fontSize: 30,
                    ),
                  ),
                  Spacer(),
                  Image.asset(
                    'assets/municipios/profile.png',
                    width: 40,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: TextFormField(
                style: TextStyle(color: Colors.black54),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(249, 113, 15, 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(249, 113, 15, 1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(249, 113, 15, 1),
                    ),
                  ),
                  hintText: "Buscar",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/municipios/penjamo.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.5,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Penjamo",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Lugar de sabinos",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage('assets/municipios/abasolo.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Abasolo",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Cuitzeo de los Naranjos",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage('assets/municipios/irapuato.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Irapuato",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "El lugar de las fresas",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage('assets/municipios/leon.jpeg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Leon",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Cultura y tradicion",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: AssetImage('assets/municipios/guanajuato.png'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guanajuato",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Lugar de muchos cerros",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 0.5,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Proximamente...",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "",
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

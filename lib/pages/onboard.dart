import 'package:flutter/material.dart';
import 'package:travel_app_02/const.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_app_02/pages/login.dart';
import 'package:travel_app_02/pages/register.dart';

class OnboardModel {
  final String title;
  final String description;
  final String lottie;

  OnboardModel({
    required this.title,
    required this.description,
    required this.lottie,
  });
}

List<OnboardModel> onboards = [
  OnboardModel(
    title: 'Bienvenido',
    description:
        'Experiencias mexico magico te ofrece un servicio\n de exploracion',
    lottie: 'primero.json',
  ),
  OnboardModel(
    title: 'Diferentes ubicaciones',
    description:
        'Cuando viajes a un lugar turistico te recomendaremos\notros lugares que puedes visitar',
    lottie: 'ubicacion.json',
  ),
  OnboardModel(
    title: 'Al alcance de tu mano',
    description:
        'Mira los lugares mas visitados de diferentes estados\ny ver que opinan los demas',
    lottie: 'inicio.json',
  ),
  OnboardModel(
    title: 'Consultar informacion.',
    description:
        'Conoce los horarios, telefono o otros\ndatos del lugar que quieres visitar',
    lottie: 'final.json',
  ),
];

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int pageView = 0;
  PageController pageController = PageController();

  void _goToRegisterScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            pageView = value;
          });
        },
        children: List.generate(
          onboards.length,
          (index) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 360, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (pageController.hasClients) {
                                pageController.animateToPage(
                                  onboards.length - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Visibility(
                              visible:
                                  onboards.length - 1 != index ? true : false,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 55),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1.5, color: white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                onboards[index].title,
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                onboards[index].description,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 200,
                    child: Lottie.asset(
                      'assets/lottie_assets/${onboards[index].lottie}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 220,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboards.length,
                (index) => GestureDetector(
                  onTap: () {
                    if (pageController.hasClients) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 5,
                    width: 20,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: pageView == index ? white : white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 65),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: Container(
                height: 150,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 20, 30, 5),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: blue,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Comenzar',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward,
                                color: white,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _goToRegisterScreen,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'No tienes una cuenta? ',
                              style: TextStyle(
                                color: black.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: 'Registrarse',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

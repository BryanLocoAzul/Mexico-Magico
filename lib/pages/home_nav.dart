import 'package:flutter/material.dart';
import 'package:travel_app_02/const.dart';
import 'package:travel_app_02/models/destination_model.dart';
import 'package:travel_app_02/pages/homePage.dart';
import 'package:travel_app_02/pages/favorites.dart';
import 'package:travel_app_02/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  List<Widget> screens = [
    homePages(),
    FavoritePlacesPage(),
    Profile(),

    // Agrega más pantallas según sea necesario
  ];
  List<IconData> icons = [
    Icons.home,
    Icons.favorite,
    Icons.person_outline_rounded
  ];
  List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();
  List<Destination> recomend =
      destinations.where((element) => element.category == 'recommend').toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: IndexedStack(
              index: selectedPage,
              children: screens,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        icons.length,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = index;
                                });
                              },
                              child: Icon(
                                icons[index],
                                color: selectedPage == index
                                    ? secundary
                                    : black.withOpacity(0.5),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travel_app_02/widgets/bgblur.dart';
import 'package:travel_app_02/pages/detail.dart';
import 'package:travel_app_02/models/destination_model.dart';

class FavoritePlace {
  final String name;
  final String image;

  FavoritePlace({required this.name, required this.image});
}

class FavoritePlacesPage extends StatefulWidget {
  @override
  _FavoritePlacesPageState createState() => _FavoritePlacesPageState();
}

class _FavoritePlacesPageState extends State<FavoritePlacesPage> {
  List<FavoritePlace> _favoritePlaces = [
    FavoritePlace(name: 'hacienda', image: 'assets/lugares/hacienda.jpg'),
    FavoritePlace(name: 'sierra', image: 'assets/lugares/sierra.jpg'),
  ];

  List<FavoritePlace> _filteredPlaces = [];

  @override
  void initState() {
    _filteredPlaces = _favoritePlaces;
    super.initState();
  }

  void _filterPlaces(String query) {
    setState(() {
      _filteredPlaces = _favoritePlaces
          .where(
              (place) => place.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lugares Favoritos'),
        backgroundColor: Colors.orange, // Color de fondo del AppBar
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterPlaces,
              decoration: InputDecoration(
                hintText: 'Buscar lugar...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPlaces.length,
              itemBuilder: (context, index) {
                final place = _filteredPlaces[index];
                return Card(
                  // Tarjeta para mejorar el diseño
                  elevation: 4, // Elevación de la tarjeta
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(place.image),
                    ),
                    title: Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onTap: () {
                      // Aquí puedes agregar la lógica para mostrar más detalles del lugar
                      final Destination destination = Destination(
                        id: index, // Aquí debes proporcionar el ID correcto
                        name: place.name,
                        // Resto de los atributos del lugar
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(destination: destination),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

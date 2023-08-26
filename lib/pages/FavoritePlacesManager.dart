import 'package:flutter/material.dart';

class FavoritePlace {
  final String name;
  final String image;

  FavoritePlace({required this.name, required this.image});
}

class FavoritePlacesManager extends ChangeNotifier {
  List<FavoritePlace> _favoritePlaces = [];

  List<FavoritePlace> get favoritePlaces => _favoritePlaces;

  void addFavoritePlace(FavoritePlace place) {
    _favoritePlaces.add(place);
    notifyListeners();
  }

  void removeFavoritePlace(FavoritePlace place) {
    _favoritePlaces.remove(place);
    notifyListeners();
  }

  bool isPlaceFavorite(FavoritePlace place) {
    return _favoritePlaces.contains(place);
  }
}

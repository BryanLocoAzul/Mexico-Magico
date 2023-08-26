import 'package:flutter/material.dart';
import 'package:travel_app_02/const.dart';
import 'package:travel_app_02/models/destination_model.dart';
import 'package:travel_app_02/pages/detail.dart';
import 'package:travel_app_02/widgets/destination_hor.dart';
import 'package:travel_app_02/widgets/destination_ver.dart';
import 'package:travel_app_02/Maps/home_screen.dart';

void main() => runApp(MaterialApp(home: homePages()));

class homePages extends StatelessWidget {
  final List<Destination> popular =
      destinations.where((element) => element.category == 'popular').toList();
  final List<Destination> recomend =
      destinations.where((element) => element.category == 'recommend').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.shade200,
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: kToolbarHeight + 20,
        backgroundColor: white,
        leadingWidth: 140,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 5),
                child: Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(249, 110, 15, 1),
                ),
              ),
              Text(
                ' Penjamo,Gto',
                style: TextStyle(
                    height: 5,
                    fontSize: 18,
                    color: primary,
                    wordSpacing: 8,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchPage(popular, recomend)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Lugares populares',
                  style: TextStyle(
                      fontSize: 16, color: black, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Ver mas',
                  style: TextStyle(
                      fontSize: 12, color: blue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: List.generate(
                popular.length,
                (index) => Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(left: 10, right: 10)
                      : const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(destination: popular[index]),
                        ),
                      );
                    },
                    child: DestinationHor(
                      destination: popular[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Lugares recomendados',
                  style: TextStyle(
                      fontSize: 16, color: black, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Ver mas',
                  style: TextStyle(
                      fontSize: 12, color: blue, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: List.generate(
                  recomend.length,
                  (index) => Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(top: 15, bottom: 15)
                        : const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(destination: recomend[index]),
                          ),
                        );
                      },
                      child: DestinationVer(
                        destination: recomend[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchPage(popular, recomend)),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  final List<Destination> popular;
  final List<Destination> recomend;

  SearchPage(this.popular, this.recomend);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Destination> filteredDestinations = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDestinations = widget.popular + widget.recomend;
  }

  void filterDestinations(String searchTerm) {
    setState(() {
      filteredDestinations = destinations
          .where((destination) =>
              destination.name
                  ?.toLowerCase()
                  .contains(searchTerm.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar destino'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                filterDestinations(value);
              },
              decoration: InputDecoration(
                hintText: 'Buscar destino...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                final destination = filteredDestinations[index];
                return ListTile(
                  title: Text(destination.name ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          destination: destination,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

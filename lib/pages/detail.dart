import 'package:flutter/material.dart';
import 'package:travel_app_02/const.dart';
import 'package:travel_app_02/models/destination_model.dart';
import 'package:travel_app_02/widgets/bgblur.dart';
import 'package:travel_app_02/maps/corralejo.dart';
import 'package:travel_app_02/maps/plazuelas.dart';
import 'package:travel_app_02/widgets/comentarios.dart';
import 'package:travel_app_02/maps/rutaTequilera.dart';
import 'package:travel_app_02/maps/custom_marker_info_window.dart';

class DetailPage extends StatefulWidget {
  final Destination destination;

  const DetailPage({Key? key, required this.destination}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  PageController pageController = PageController();
  int pageView = 0;

  void _addToFavorites() {
    // Agregar el lugar a la lista de favoritos
    // Puedes guardar el lugar en una lista o base de datos.
    // Por simplicidad, aquí solo se muestra un SnackBar de confirmación.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lugar agregado a favoritos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.shade200,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: black.withOpacity(0.3))),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: black,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Detalles',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: black),
        ),
        actions: [
          GestureDetector(
            onTap: _addToFavorites,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: black.withOpacity(0.3))),
              child: const Icon(
                Icons.favorite,
                color: red,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Container(
          decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: black.withOpacity(0.5),
                          offset: const Offset(0, 5),
                          spreadRadius: 1,
                          blurRadius: 5)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      PageView(
                        controller: pageController,
                        onPageChanged: (value) {
                          setState(() {
                            pageView = value;
                          });
                        },
                        children: List.generate(
                          widget.destination.image!.length,
                          (index) => Image.asset(
                            'assets/${widget.destination.image![index]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (pageController.hasClients) {
                                pageController.animateToPage(
                                  pageView ==
                                          widget.destination.image!.length - 1
                                      ? 0
                                      : pageView + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: white),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: widget.destination.image!.length - 1 !=
                                          pageView
                                      ? AssetImage(
                                          'assets/${widget.destination.image![pageView + 1]}')
                                      : AssetImage(
                                          'assets/${widget.destination.image![0]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          BgBlur(
                            opacity: 0.8,
                            blur: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      widget.destination.image!.length,
                                      (index) => GestureDetector(
                                        onTap: () {
                                          if (pageController.hasClients) {
                                            pageController.animateToPage(
                                              index,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          height: 5,
                                          width: 20,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                            color: pageView == index
                                                ? white
                                                : white.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.destination.name!,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: white,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                widget.destination.location!,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                color: yellow,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                '\$${widget.destination.rate!}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: white),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '(${widget.destination.review} reviews)',
                                            style: const TextStyle(
                                                color: white, fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const TabBar(
                            labelColor: blue,
                            unselectedLabelColor: black,
                            indicatorColor: blue,
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              Tab(
                                text: 'Descripcion',
                              ),
                              Tab(
                                text: 'Review',
                              ),
                            ]),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                widget.destination.description!,
                                maxLines: 3,
                                style: TextStyle(
                                    color: black.withOpacity(0.6),
                                    fontSize: 12,
                                    height: 1.5),
                              ),
                            ),
                            CommentsWidget(),
                          ],
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
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (widget.destination.id == 2) {
                  _showDetailsModal(context, widget.destination);
                } else if (widget.destination.id == 3) {
                  _showDetailsModal(context, widget.destination);
                } else if (widget.destination.id == 7) {
                  _showDetailsModal(context, widget.destination);
                } else if (widget.destination.id == 8) {
                  _showDetailsModal(context, widget.destination);
                }
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Saber más',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsModal(BuildContext context, Destination destination) {
    final isOpen = destination.isOpenNow();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                destination.name!,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 10),
              Text(
                destination.description!,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 10),
              Text(
                "Horarios:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              if (destination.openingHours != null &&
                  destination.openingHours!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: destination.openingHours!
                      .map(
                        (hour) => Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 16, color: Colors.blue),
                            SizedBox(width: 5),
                            Text(
                              hour,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    isOpen ? Icons.check_circle_outline : Icons.cancel_outlined,
                    size: 18,
                    color: isOpen ? Colors.green : Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    isOpen ? "Abierto" : "Cerrado",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isOpen ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 18,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 5),
                  Text(
                    destination.phoneNumber ?? "No disponible",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Navegar a la página de mapa según el id del destino
                  if (destination.id == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomMarkerInfoWindowScreen()), // Reemplaza MapPage2 con el nombre de tu página de mapa correspondiente
                    );
                  } else if (destination.id == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PlazuelasMap()), // Reemplaza MapPage3 con el nombre de tu página de mapa correspondiente
                    );
                  } else if (destination.id == 7) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CustomMarkerInfoWindowScreen2()), // Reemplaza MapPage7 con el nombre de tu página de mapa correspondiente
                    );
                  } else if (destination.id == 8) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Corralejomap()), // Reemplaza MapPage8 con el nombre de tu página de mapa correspondiente
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(Icons.map, size: 20),
                label: Text(
                  "Ver mapa",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

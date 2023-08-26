import 'dart:math';
import 'package:flutter/material.dart';

Random random = Random();

class Destination {
  final int? id, price, review;
  final List<String>? image;
  final String? name, description, category, location, phoneNumber;
  final List<String>? openingHours;

  final double? rate;

  Destination(
      {this.name,
      this.price,
      this.id,
      this.category,
      this.description,
      this.review,
      this.image,
      this.rate,
      this.phoneNumber,
      this.openingHours,
      this.location});

  bool isOpenNow() {
    if (openingHours == null) return false;
    final now = TimeOfDay.now();
    final currentTime = now.hour * 60 + now.minute;

    for (final hours in openingHours!) {
      final parts = hours.split(" ");
      if (parts.length != 3) continue;

      final timeParts = parts[0].split(":");
      if (timeParts.length != 2) continue;

      final hour = int.tryParse(timeParts[0]);
      final minute = int.tryParse(timeParts[1]);
      final period = parts[2];

      if (hour == null || minute == null) continue;

      int startTime = hour * 60 + minute;

      if (period.toLowerCase() == "pm") {
        startTime += 12 * 60;
      }

      final endTime = startTime + 60 * 2; // Assuming 2 hours of opening time

      if (currentTime >= startTime && currentTime <= endTime) {
        return true;
      }
    }

    return false;
  }

  String getFormattedTime(String timeString) {
    final parts = timeString.split(" ");
    if (parts.length != 3) return timeString;

    final timeParts = parts[0].split(":");
    if (timeParts.length != 2) return timeString;

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    final period = parts[2];

    if (hour == null || minute == null) return timeString;

    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $period';
  }
}

List<Destination> destinations = [
  Destination(
    id: 2,
    name: "Sierra de Penjamo",
    category: 'popular',
    image: [
      "lugares/sierra.jpg",
      "lugares/sierra2.jpg",
      "lugares/sierra3.jpg",
      "lugares/sierra4.jpg",
    ],
    phoneNumber: "+52 123 456 7890",
    location: "Penjamo,Gto",
    review: random.nextInt(300) + 25,
    price: random.nextInt(95) + 23,
    description:
        "Esta región cuenta con una amplia riqueza biológica representada en sus suelos, arroyos y cuerpos de agua. Está constituida tanto al sur como en el norte, de lomeríos volcánicos, al suroeste por una depresión de depósitos perennes y al sureste se ubican las elevaciones más altas de la región.",
    rate: 4.6,
    openingHours: ["9:00 AM - 6:00 PM", "Cerrado los domingos"],
  ),
  Destination(
    id: 7,
    price: random.nextInt(95) + 23,
    name: "tequilera corralejo",
    image: [
      "lugares/tequilera.jpg",
      "lugares/tequilera2.jpg",
      "lugares/tequilera3.jpg",
      "lugares/tequilera4.jpg",
    ],
    phoneNumber: "+52 123 456 123",
    review: random.nextInt(300) + 25,
    category: "popular",
    location: "Penjamo, Gto",
    description:
        "Hacienda Corralejo es un excelente lugar para conocer, ir con la familia, amigos y disfrutar de un lugar único. Al acercarse",
    rate: 4,
    openingHours: ["9:00 AM - 6:00 PM", "Cerrado los domingos"],
  ),
  Destination(
    id: 3,
    name: "Plazuelas",
    review: random.nextInt(300) + 25,
    price: random.nextInt(95) + 23,
    category: 'recommend',
    image: [
      "lugares/plazuela.jpg",
      "lugares/plazuela2.jpg",
      "lugares/plazuela3.jpg",
    ],
    phoneNumber: "+52 123 456 444",
    location: "Penjamo,Gto",
    description:
        "Plazuelas sobresale por su integración al paisaje, edificándose cuidadosamente para no romper el orden de su entorno. La ocupación de este sitio se dio entre 450 y 900 d.C.,",
    rate: 4.5,
    openingHours: ["9:00 AM - 6:00 PM", "Cerrado los domingos"],
  ),
  Destination(
    id: 8,
    name: "Hacienda corralejo",
    review: random.nextInt(300) + 25,
    price: random.nextInt(95) + 23,
    category: "recommend",
    image: [
      "lugares/hacienda.jpg",
      "lugares/hacienda2.jpg",
      "lugares/hacienda3.jpg",
    ],
    phoneNumber: "+52 123 456 000",
    location: "Penjamo, Gto",
    description:
        "Hacienda Corralejo ha albergado innumerables eventos y fechas importantes, en cada uno de sus espacios es posible disfrutar de México. Hacienda Corralejo además de ser una fábrica tequilera es también un centro de eventos sociales donde podrás llevar ese mágico momento a la historia, ven y realiza tus eventos ",
    rate: 4,
    openingHours: ["8:00 AM - 6:00 PM", "Cerrado sabados y domingos"],
  ),
];

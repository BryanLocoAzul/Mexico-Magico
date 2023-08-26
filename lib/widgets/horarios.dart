import 'package:flutter/material.dart';

class HorariosWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        // Añadir SingleChildScrollView aquí
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Horarios:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            DayHorarioWidget(
              dia: 'Lunes',
              horario: '9:00 AM - 5:00 PM',
            ),
            DayHorarioWidget(
              dia: 'Martes',
              horario: '9:00 AM - 5:00 PM',
            ),
            DayHorarioWidget(
              dia: 'Miercoles',
              horario: '9:00 AM - 5:00 PM',
            ),
            // Agregar aquí los horarios para otros días de la semana
          ],
        ),
      ),
    );
  }
}

class DayHorarioWidget extends StatelessWidget {
  final String dia;
  final String horario;

  const DayHorarioWidget({
    required this.dia,
    required this.horario,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today), // Icono del calendario
            SizedBox(width: 5),
            Text(
              dia + ':',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.access_time), // Icono del reloj
            SizedBox(width: 5),
            Text(
              horario,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

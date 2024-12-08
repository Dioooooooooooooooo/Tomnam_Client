import 'package:flutter/material.dart';
import '../calendar_widget.dart';
import '../reservation.dart';
import '../reservation_widget.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

// hardcoded
final Map<DateTime, List<Reservation>> reservations = {
  DateTime(2024, 12, 8): [
    Reservation('bh ni james', [
      {'etlog': 3},
      {'sprite': 1},
    ]),
    Reservation('karendearya ni tino', [
      {'siomai': 1},
    ]),
  ],
  DateTime(2024, 12, 9): [
    Reservation('cit canteen', [
      {'milo nga tag traynta': 1},
    ]),
  ],
};

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();

  // Normalize date to remove time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Get reservations for a specific day
  // GPT: Normalizing the date ensures you can correctly fetch data regardless of the time part.
  List<Reservation> getReservationsForDay(DateTime day) {
    return reservations[_normalizeDate(day)] ?? [];
  }

  // Update selected day
  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Calendar Widget
              CalendarWidget(
                selectedDay: selectedDay,
                onDaySelected: onDaySelected,
                events: reservations,
              ),
              const SizedBox(height: 16.0),
              // Reservation List
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                        8.0), // Add padding for better layout
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          '${getReservationsForDay(selectedDay).length} RESERVATIONS',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                            height:
                                8.0), // Add spacing between text and the list
                        Column(
                          children: getReservationsForDay(selectedDay)
                              .map((reservation) {
                            return ReservationWidget(
                              reservation: reservation,
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/utils/constants/routes.dart';
import '../calendar_widget.dart';
import '../reservation_widget.dart';
import '../../controllers/calendar_controller.dart';
import '../../reserve/screens/generate_code_page.dart';
import '../../../models/reservation.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();
  late Future<List<Reservation>> _reservationsFuture;
  Map<DateTime, List<Reservation>> _reservationsMap = {};

  bool? _isOwner;
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void initState() {
    super.initState();
    _reservationsFuture = _fetchAndOrganizeReservations();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final user = await ProfileController.getUser();
      setState(() {
        _isOwner = user.role == 'Owner';
      });
    } catch (e) {
      _logger.e('Error fetching user: $e');
    }
  }

  Future<List<Reservation>> _fetchAndOrganizeReservations() async {
    try {
      final reservations = await CalendarController.fetchReservations();

      // Organize reservations by date
      _reservationsMap = _groupReservationsByDate(reservations);
      // Group reservations by time for the current day
      reservationsByTime = _groupReservationsByTime(selectedDay);

      return reservations;
    } catch (e) {
      // Handle error
      print('Error fetching reservations: $e');
      return [];
    }
  }

  // Group reservations by date
  Map<DateTime, List<Reservation>> _groupReservationsByDate(
      List<Reservation> reservations) {
    Map<DateTime, List<Reservation>> groupedReservations = {};

    for (var reservation in reservations) {
      // Normalize the date by removing time
      DateTime normalizedDate = DateTime(
        reservation.reserveDateTime.year,
        reservation.reserveDateTime.month,
        reservation.reserveDateTime.day,
      );

      // Add to grouped reservations
      if (!groupedReservations.containsKey(normalizedDate)) {
        groupedReservations[normalizedDate] = [];
      }
      groupedReservations[normalizedDate]!.add(reservation);
    }

    return groupedReservations;
  }

  // Group reservations by time for a specific day
  Map<String, List<Reservation>> _groupReservationsByTime(DateTime day) {
    List<Reservation> reservationsToday = getReservationsForDay(day);

    // Group reservations by time
    Map<String, List<Reservation>> reservationsByTime = {};
    for (var reservation in reservationsToday) {
      String timeKey =
          '${reservation.reserveDateTime.hour.toString().padLeft(2, '0')}:${reservation.reserveDateTime.minute.toString().padLeft(2, '0')}';
      if (!reservationsByTime.containsKey(timeKey)) {
        reservationsByTime[timeKey] = [];
      }
      reservationsByTime[timeKey]!.add(reservation);
    }
    return reservationsByTime;
  }

  // Normalize date to remove time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Get reservations for a specific day
  List<Reservation> getReservationsForDay(DateTime day) {
    return _reservationsMap[_normalizeDate(day)] ?? [];
  }

  // Update selected day
  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      selectedDay = day;
      // Re-fetch and re-organize data when the day changes
      _reservationsFuture = _fetchAndOrganizeReservations();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Flatten the grouped reservations for AnnouncementSection
  List<Reservation> reservationsToday = [];
    reservationsByTime?.forEach((time, reservations) {
    reservationsToday.addAll(reservations);
  });
    return Scaffold(
      body: FutureBuilder<List<Reservation>>(
        future: _reservationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Get today's reservations grouped by time
          reservationsByTime = _groupReservationsByTime(selectedDay);

          // Flatten the grouped reservations for AnnouncementSection
          List<Reservation> reservationsToday = [];
          reservationsByTime?.forEach((time, reservations) {
            reservationsToday.addAll(reservations);
          });

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  // Calendar Widget
                  CalendarWidget(
                    selectedDay: selectedDay,
                    onDaySelected: onDaySelected,
                    events: _reservationsMap,
                  ),
                  const SizedBox(height: 16.0),
                  // Reservation List
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getReservationsForDay(selectedDay).length} RESERVATIONS',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Column(
                          children: getReservationsForDay(selectedDay)
                              .map((reservation) {
                            return ReservationWidget(
                              reservation: reservation,
                              onScanTap: () {
                                // Navigate to QR code generation page, scammer charlene
                                if (!_isOwner!) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GenerateCodePage(
                                        reservationId: reservation.id,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Navigate to Scanner
                                  Navigator.pushNamed(
                                      context, scanQrCodePageRoute);
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

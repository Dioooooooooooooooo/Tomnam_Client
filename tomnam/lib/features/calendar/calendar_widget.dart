import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/reservation.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Map<DateTime, List<Reservation>> events;

  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
    this.events = const {},
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  // Normalize date to ignore time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, widget.selectedDay),
      focusedDay: widget.selectedDay,
      firstDay: DateTime.utc(2019, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
      onDaySelected: widget.onDaySelected,
      eventLoader: (day) =>
          widget.events[_normalizeDate(day)] ?? [], // Load events
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isEmpty) return null; // No markers if no events
          return Positioned(
            bottom: 1, // Position dots below the date
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(events.length, (index) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange, // Adjust the color
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

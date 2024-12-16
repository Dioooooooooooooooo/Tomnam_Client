import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import 'package:tomnam/features/controllers/calendar_controller.dart';
import 'package:tomnam/models/reservation.dart';
import 'package:tomnam/provider/karenderya_provider.dart';
import '../../../commons/widgets/announcement_section.dart';
import '../../../commons/widgets/store_list_horizontal.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onNavigateToCalendar;

  const HomePage({super.key, required this.onNavigateToCalendar});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabs = ["All", "Nearby Store", "Top Food"];
  // final List<Karenderya> stores = [];
  DateTime selectedDay = DateTime.now().toUtc().add(const Duration(hours: 8));
  late List<Reservation> _reservations;
  final List<Reservation> _reservationsToday = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchAndOrganizeReservations();
  }

  final _logger = Logger(printer: PrettyPrinter());

  int selectedTabIndex = 0;
  Future<void> _fetchAndOrganizeReservations() async {
    try {
      final reservations = await CalendarController.fetchReservations();
      _reservations = reservations;
      // Organize reservations by date
      _filterReservationsToday();
    } catch (e) {
      // Handle error
      print('Error fetching reservations: $e');
    }
  }

  // Group reservations by date
  Future<void> _filterReservationsToday() async {
    for (Reservation reservation in _reservations) {
      if (DateFormat("yyyy-MM-dd").format(reservation.reserveDateTime) ==
          DateFormat("yyyy-MM-dd").format(selectedDay)) {
        _reservationsToday.add(reservation);
      }
    }

    _logger.d(_reservationsToday);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider =
        Provider.of<KarenderyaProvider>(context, listen: false);
    final stores = storeProvider.stores;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ListView(
                children: [
                  // Announcement Section with today's reservations
                  AnnouncementSection(
                      reservationsToday: _reservationsToday,
                      onNavigateToCalendar: widget.onNavigateToCalendar),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeadlineText(
                          text: "Latest Reservations",
                          size: HeadlineSize.small,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        StoreListHorizontal(stores),
                        const SizedBox(height: 20),
                        const HeadlineText(
                          text: "Reserve Now",
                          size: HeadlineSize.small,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        StoreListVertical(stores),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import 'package:tomnam/models/karenderya.dart';
import 'package:tomnam/features/controllers/karenderyas_controller.dart';
import '../../../commons/widgets/announcement_section.dart';
import '../../../commons/widgets/store_list_horizontal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );
  List<Karenderya> _stores = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKarenderyas(); // Fetch data on widget initialization
  }

  Future<void> _fetchKarenderyas() async {
    try {
      final stores = await KarenderyasController.read(
        null, // karenderyaId
        null, // name
        null, // locationStreet
        null, // locationBarangay
        null, // locationCity
        null, // locationProvince
      );
      _logger.d('Stores: $stores');
      setState(() {
        _stores = stores;
        _isLoading = false;
      });
    } catch (e) {
      _logger.e('Error fetching Karenderyas: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<String> tabs = ["All", "Nearby Store", "Top Food"];

  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loader while fetching
            : ListView(
                children: [
                  const AnnouncementSection(),
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
                        StoreListHorizontal(_stores),
                        const SizedBox(height: 20),
                        const HeadlineText(
                          text: "Reserve Now",
                          size: HeadlineSize.small,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 10),
                        StoreListVertical(_stores),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

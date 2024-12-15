import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/store_list_vertical.dart';
import 'package:tomnam/provider/karenderya_provider.dart';
import '../../../commons/widgets/announcement_section.dart';
import '../../../commons/widgets/store_list_horizontal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabs = ["All", "Nearby Store", "Top Food"];
  // final List<Karenderya> stores = [];

  int selectedTabIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<KarenderyaProvider>(context, listen: false);
    final stores = storeProvider.stores;
    
    return Scaffold(
      body: SafeArea(
        child: 
            ListView(
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

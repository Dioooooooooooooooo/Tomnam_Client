import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/features/calendar/screens/calendar_page.dart';
import 'package:tomnam/features/controllers/cart_item_controller.dart';
import 'package:tomnam/features/controllers/karenderyas_controller.dart';
import 'package:tomnam/features/home/screens/home_page.dart';
import 'package:tomnam/features/profile_management/screens/profile_page.dart';
import 'package:tomnam/commons/widgets/bottom_navbar.dart';
import 'package:tomnam/provider/cart_item_provider.dart';
import '../../../commons/widgets/upper_navbar.dart';
import 'package:tomnam/provider/karenderya_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainPage> {
  int _currentIndex = 1;
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );
  final List<Widget> _pages = [
    const CalendarPage(),
    const HomePage(),
    const ProfilePage(),
  ];
  bool isLoading = true;

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
      final storeProvider = Provider.of<KarenderyaProvider>(context, listen: false);
      storeProvider.setStores(stores);
      final cartItems = await CartItemController.read();
      final cartItemProvider = Provider.of<CartItemProvider>(context, listen: false);
      cartItemProvider.setCartItems(cartItems);
    } catch (e) {
      _logger.e('Error fetching Karenderyas: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    isLoading ? const Center(child: CircularProgressIndicator()) :
    Scaffold(
      appBar: AppBar(
        flexibleSpace: const UpperNavBar(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/Exceptions/response_exception.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/label_text.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import 'package:tomnam/data/services/api_service.dart';
import 'package:tomnam/features/controllers/profile_controller.dart';
import 'package:tomnam/features/controllers/reservation_controller.dart';
import 'package:tomnam/features/controllers/transactions_controller.dart';
import 'package:tomnam/models/reservation.dart';
import 'package:intl/intl.dart';
import 'package:tomnam/models/reserved_item.dart';
import 'package:tomnam/models/user.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';

class ConfirmReservationPage extends StatefulWidget {
  const ConfirmReservationPage({super.key});

  @override
  State<ConfirmReservationPage> createState() => _ConfirmReservationPageState();
}

class _ConfirmReservationPageState extends State<ConfirmReservationPage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  bool _isLoading = true;
  late String _reservationId;
  Reservation? _reservation;
  User? _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is Map<String, dynamic>) {
      _reservationId = arguments['reservationId'] as String;
      _fetchReservation();
      _logger.d('Received reservation data: $_reservationId');
    } else {
      _logger.e('No user data found in arguments');
    }
  }

  Future<void> _fetchReservation() async {
    try {
      final reservation = await ReservationController.get(_reservationId);

      _logger.d('Reservation: $reservation');
      setState(() {
        _reservation = reservation;
      });

      _fetchUser();
    } catch (e) {
      _logger.e('Error fetching Reservation: $e');
    }
  }

  Future<void> _fetchUser() async {
    try {
      final user = await ProfileController.getUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      _logger.e('Error fetching user: $e');
    }
  }

  Future<void> _confirmReservation() async {
    try {
      final message = await TransactionsController.confirm(
          {'ReservationId': _reservationId});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      Navigator.of(context)
          .pushNamedAndRemoveUntil(mainPageRoute, (route) => false);
    } catch (e, stackTrace) {
      if (!context.mounted) return;
      String? message;
      if (e is ResponseException) {
        message = e.error;
      } else {
        message = 'An error occurred during confirmation of reservation';
      }
      _logger.d(stackTrace);
      _logger.e('An error occurred during confirmation of reservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show loader while fetching
              : _user!.Id == _reservation!.karenderya.ownerId
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 15),
                      child: ListView(
                        children: [
                          const SizedBox(height: 24),
                          const HeadlineText(
                              text: 'Reservation Details',
                              textAlign: TextAlign.left),
                          LabelText(
                              text: 'Id: ${_reservation!.id}',
                              size: LabelSize.medium,
                              textAlign: TextAlign.left),
                          LabelText(
                              text:
                                  'Reserved Date: ${DateFormat("MMMM d, yyyy").format(_reservation!.reserveDateTime)}}',
                              size: LabelSize.small,
                              textAlign: TextAlign.left),
                          LabelText(
                              text:
                                  'Reserved Time: ${DateFormat('hh:mm a').format(_reservation!.reserveDateTime)}',
                              size: LabelSize.small,
                              textAlign: TextAlign.left),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: _reservation!.reservedItems.length,
                                  itemBuilder: (context, index) {
                                    return _buildReservedItems(
                                        _reservation!.reservedItems[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const TitleText(
                                text: 'Reservation Total: ',
                                textAlign: TextAlign.left,
                                size: TitleSize.medium,
                              ),
                              HeadlineText(
                                text: 'Php ${_reservation!.total}',
                                size: HeadlineSize.small,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            child: _reservation!.status == 'Pending'
                                ? TextButton(
                                    onPressed: _confirmReservation,
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            AppColors.secondMainGreenColor)),
                                    child: const Text(
                                      'Confirm Reservation',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              mainPageRoute, (route) => false);
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            AppColors.mainOrangeColor)),
                                    child: const Text(
                                      'Reservation Paid',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const HeadlineText(
                              text: 'Sorry :< You cannot access this page.',
                              size: HeadlineSize.medium),
                          const SizedBox(height: 24),
                          const TitleText(
                            text:
                                'You are not the owner of the Karenderya which this reservation belongs to.',
                            size: TitleSize.medium,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 100,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    mainPageRoute, (route) => false);
                              },
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.accentRedOrangeColor),
                              ),
                              child: const Text(
                                "Back",
                                style: TextStyle(
                                    color: AppColors.whiteColor, fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
    );
  }

  Widget _buildReservedItems(ReservedItem item) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with padding between image and text
            Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              '${ApiService.baseURL}/${item.food.foodPhoto}'),
                          fit: BoxFit.cover)),
                )),
            // Column with foodName and price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.food.foodName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Php ${item.food.unitPrice}"),
                ],
              ),
            ),
            // Quantity display at the right
            Text("x${item.quantity}",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

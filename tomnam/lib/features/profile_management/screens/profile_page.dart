import 'package:flutter/material.dart';
import '../../../commons/widgets/behavior_score.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
          children: const [
            Text('Details about the profile.'),
            SizedBox(height: 20), // Add spacing between widgets
            BehaviorScore(),
          ],
        ),
      ),
    );
  }
}

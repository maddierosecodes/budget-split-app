import 'package:evenedge/widgets/common/app_bar_title.dart';
import 'package:evenedge/widgets/common/back_button.dart';
import 'package:evenedge/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const AppBarTitle(title: 'Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrimaryButton(
              onPressed: () {
                // No action for now
              },
              text: 'Remove User Data',
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              onPressed: () {
                // No action for now
              },
              text: 'Restore Purchases',
            ),
          ],
        ),
      ),
    );
  }
}

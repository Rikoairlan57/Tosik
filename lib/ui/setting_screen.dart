import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tosik/provider/preferences_provider.dart';
import 'package:tosik/provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (_, preferences, __) {
          return Consumer<SchedulingProvider>(
            builder: (_, scheduled, __) {
              return SwitchListTile(
                title: const Text('Daily Reminder'),
                value: preferences.isDailyReminderActive,
                onChanged: (value) async {
                  scheduled.scheduledReminder(value);
                  preferences.enableDailyReminder(value);
                },
              );
            },
          );
        },
      ),
    );
  }
}

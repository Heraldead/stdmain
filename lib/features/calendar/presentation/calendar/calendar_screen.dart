import 'package:flutter/material.dart';
import 'package:std/core/widgets/custom_app_bar.dart';

import 'components/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBarWidget(
              title: 'Календарь',
              icon: '📅',
              isShowBackButton: true,
            ),
            const SizedBox(height: 12),
            CalendarWidget(
              getEventsForDay: (DateTime dataTime) {
                return [];
              },
              onSelectedDay: (DateTime dateTime) {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    Key? key,
    required this.getEventsForDay,
    required this.onSelectedDay,
  }) : super(key: key);

  final List<RecordModel> Function(DateTime dataTime) getEventsForDay;
  final void Function(DateTime dateTime) onSelectedDay;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      locale: 'ru',
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Неделя',
        CalendarFormat.twoWeeks: 'Месяц',
        CalendarFormat.week: '2 недели',
      },
      eventLoader: widget.getEventsForDay,
      calendarStyle: CalendarStyle(
        selectedDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFF03F54),
        ),
        todayDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF005BA1),
          ),
        ),
        todayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        markerDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black87,
        ),
      ),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            widget.onSelectedDay(selectedDay);
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}

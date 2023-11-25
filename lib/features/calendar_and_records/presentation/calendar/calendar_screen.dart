import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:std/core/app_color.dargt.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';
import 'package:std/features/calendar_and_records/presentation/calendar/components/record.dart';
import 'package:std/features/calendar_and_records/presentation/event_record/event_record_screen.dart';

import '../../providers/calendar_and_records_provider.dart';
import 'components/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    CalendarAndRecordsProvider calendarAndRecordsProvider =
        context.watch<CalendarAndRecordsProvider>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005BA1),
        focusColor: const Color(0xFFF03F54),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) {
              return const EventRecordScreen();
            },
          ));
        },
        child: const Center(
          child: Text(
            '📝',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBarWidget(
              title: 'Календарь здоровья',
              icon: '📅',
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    ColoredBox(
                      color: Colors.white,
                      child: CalendarWidget(
                        getEventsForDay: (DateTime dataTime) {
                          String dateKey = DateFormat('yMd').format(dataTime);
                          return calendarAndRecordsProvider.state[dateKey] ??
                              [];
                        },
                        onSelectedDay: (DateTime dateTime) {
                          setState(() {
                            selectDate = dateTime;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      key: UniqueKey(),
                      child: RecordEntriesWidget(
                        listRecordModel: calendarAndRecordsProvider
                                .state[DateFormat('yMd').format(selectDate)] ??
                            [],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordEntriesWidget extends StatelessWidget {
  const RecordEntriesWidget({
    super.key,
    required this.listRecordModel,
  });

  final List<RecordModel> listRecordModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: listRecordModel.length,
      itemBuilder: (context, index) {
        return RecordWidget(
          recordModel: listRecordModel[index],
          onTap: (record) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => RecordInformationWidget(
                record: record,
              ),
            ));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }
}

class RecordInformationWidget extends StatelessWidget {
  const RecordInformationWidget({super.key, required this.record});

  final RecordModel record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(
              title: record.type.title,
              icon: '📰',
              isShowBackButton: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMd('ru').add_Hm().format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.parse(record.timestamp),
                              ),
                            ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(color: AppColor.black),
                      if (record.partner.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Партнёр',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          record.partner,
                          style: const TextStyle(color: AppColor.black),
                        ),
                      ],
                      if (record.listSymptoms.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Симптомы',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (_, index) =>
                              Text('  -  ${record.listSymptoms[index]}'),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 6),
                          itemCount: record.listSymptoms.length,
                        ),
                      ],
                      const SizedBox(height: 12),
                      const Text(
                        'Заметка',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        record.message,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

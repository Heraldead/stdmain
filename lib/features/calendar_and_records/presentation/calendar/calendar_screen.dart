import 'package:flutter/material.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';
import 'package:std/features/calendar_and_records/presentation/calendar/components/record.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBarWidget(
              title: 'Календарь',
              icon: '📅',
              isShowBackButton: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    CalendarWidget(
                      getEventsForDay: (DateTime dataTime) {
                        return [];
                      },
                      onSelectedDay: (DateTime dateTime) {
                        setState(() {
                          selectDate = dateTime;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      key: UniqueKey(),
                      child: const RecordEntriesWidget(
                        listRecordModel: [
                          RecordModel(
                            type: TypeRecord.symptoms,
                            partner: '1231',
                            message: '1231243',
                            listSymptoms: ['213'],
                            timestamp: '123123',
                          ),
                          RecordModel(
                            type: TypeRecord.sexualHealth,
                            partner: '1231',
                            message: '1231243',
                            listSymptoms: ['213'],
                            timestamp: '123123',
                          ),
                        ],
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
            onTap: (_) {},
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:intl/intl.dart';
import 'package:std/core/domain/entities/descrription_entities.dart';
import 'package:std/core/widgets/custom_app_bar.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';

import 'components/symptoms_selection.dart';
import 'components/text_field_custom.dart';
import 'components/toogle_button.dart';

class EventRecordScreen extends StatefulWidget {
  const EventRecordScreen({super.key});

  @override
  State<EventRecordScreen> createState() => _EventRecordScreenState();
}

class _EventRecordScreenState extends State<EventRecordScreen> with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: TypeRecord.values.length,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBarWidget(
              title: 'Новая запись',
              icon: '📝',
              isShowBackButton: true,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ToggleButtonWidget(
                      onEvent: (index) {
                        tabController.animateTo(index);
                      },
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          SexualHealthView(),
                          SymptomsView(),
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

class SexualHealthView extends StatefulWidget {
  const SexualHealthView({super.key});

  @override
  State<SexualHealthView> createState() => _SexualHealthViewState();
}

class _SexualHealthViewState extends State<SexualHealthView> {
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();
  String partner = '';
  String comment = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                TextFieldCustomWidget(
                  labelText: 'Партнёр',
                  helpText: 'Введите имя партнёра',
                  onChanged: (value) {
                    setState(() {
                      partner = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(child: _buildDatePicker(context)),
                    const SizedBox(width: 16),
                    Flexible(child: _buildTimePicker(context)),
                  ],
                ),
                const SizedBox(height: 16),
                TextFieldCustomWidget(
                  labelText: 'Заметка',
                  onChanged: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                  minLines: 5,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ScaleTap(
          child: Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF005BA1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Сохранить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  GestureDetector _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 150)),
          lastDate: DateTime.now().add(const Duration(days: 150)),
        ).then((value) {
          setState(() {
            selectDate = value ?? DateTime.now();
          });
        });
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7F7F7F)),
        ),
        alignment: Alignment.center,
        child: Text(
          DateFormat.yMd('ru').format(selectDate),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((value) {
          setState(() {
            selectTime = value ?? TimeOfDay.now();
          });
        });
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7F7F7F)),
        ),
        alignment: Alignment.center,
        child: Text(
          selectTime.format(context),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class SymptomsView extends StatefulWidget {
  const SymptomsView({super.key});

  @override
  State<SymptomsView> createState() => _SymptomsViewState();
}

class _SymptomsViewState extends State<SymptomsView> {
  DateTime selectDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();
  String partner = '';
  String comment = '';

  List<SymptomsTileModel> listSymptoms = DescriptionEntity.getTags().map((e) => SymptomsTileModel(symptom: e)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                SymptomsSelectionWidget(
                  listSymptoms: listSymptoms,
                  onChoiceOfTile: (List<SymptomsTileModel> list) {
                    print(list);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(child: _buildDatePicker(context)),
                    const SizedBox(width: 16),
                    Flexible(child: _buildTimePicker(context)),
                  ],
                ),
                const SizedBox(height: 16),
                TextFieldCustomWidget(
                  labelText: 'Заметка',
                  onChanged: (value) {
                    setState(() {
                      comment = value;
                    });
                  },
                  minLines: 5,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        ScaleTap(
          child: Container(
            height: 40,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF005BA1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Сохранить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  GestureDetector _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 150)),
          lastDate: DateTime.now().add(const Duration(days: 150)),
        ).then((value) {
          setState(() {
            selectDate = value ?? DateTime.now();
          });
        });
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7F7F7F)),
        ),
        alignment: Alignment.center,
        child: Text(
          DateFormat.yMd('ru').format(selectDate),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((value) {
          setState(() {
            selectTime = value ?? TimeOfDay.now();
          });
        });
      },
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7F7F7F)),
        ),
        alignment: Alignment.center,
        child: Text(
          selectTime.format(context),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

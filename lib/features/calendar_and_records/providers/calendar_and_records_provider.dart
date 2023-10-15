import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';

class CalendarAndRecordsProvider extends ChangeNotifier {
  late Map<String, List<RecordModel>> state;
  final SharedPreferences sharedPreferences;

  CalendarAndRecordsProvider({required this.sharedPreferences}) {
    getStateFromSharedPreferences();
  }

  void saveRecords(RecordModel record) {
    final dateKey = record.dateString;
    if (state.containsKey(dateKey)) {
      state[dateKey]?.add(record);
    } else {
      state[dateKey] = [record];
    }
    notifyListeners();
    saveStateToSharedPreferences();
  }

  Future<bool> saveStateToSharedPreferences() async {
    var stateString = state.map((key, value) => MapEntry(
        key,
        value
            .map(
              (e) => e.toMap(),
            )
            .toList()));

    return await sharedPreferences.setString('records', jsonEncode(stateString));
  }

  void getStateFromSharedPreferences() {
    final String? recordsJson = sharedPreferences.getString('records');
    if (recordsJson != null) {
      final Map<String, List<dynamic>> recordsString =
          (jsonDecode(recordsJson) as Map<String, dynamic>).cast<String, List<dynamic>>();
      var recordsMapString = recordsString.map((key, value) => MapEntry(key, value.cast<Map<String, dynamic>>()));
      state = recordsMapString.map((key, value) => MapEntry(
            key,
            value.map((e) => RecordModel.fromMap(e)).toList(),
          ));
    } else {
      state = {};
    }
  }
}

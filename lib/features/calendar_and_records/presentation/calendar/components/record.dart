import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:std/features/calendar_and_records/models/record_model.dart';

class RecordWidget extends StatelessWidget {
  const RecordWidget({
    super.key,
    required this.recordModel,
    required this.onTap,
  });

  final RecordModel recordModel;
  final ValueChanged<RecordModel> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call(recordModel);
      },
      child: Ink(
        width: double.infinity,
        height: 84,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                recordModel.type == TypeRecord.symptoms ? 'assets/icons/disease.svg' : 'assets/icons/sexual_health.svg',
                height: 48,
                width: 48,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recordModel.type.title,
                    style: const TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat.yMd('ru').add_Hms().format(
                          DateTime.fromMillisecondsSinceEpoch(
                            int.parse(recordModel.timestamp),
                          ),
                        ),
                    style: const TextStyle(
                      color: Color(0xFF7F7F7F),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    recordModel.message,
                    style: const TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

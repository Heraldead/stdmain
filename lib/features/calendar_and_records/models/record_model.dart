enum RecordEnum {
  sexualHealth('Половой акт'),
  symptoms('Симптомы');

  final String title;

  const RecordEnum(this.title);
}

class RecordModel {
  final RecordEnum type;
  final String partner; // Если половой акт
  final String message;
  final List<String> listSymptoms; // Если симптомы
  final String timestamp;
  final String dateString;

  const RecordModel({
    required this.dateString,
    required this.type,
    required this.partner,
    required this.message,
    required this.listSymptoms,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'RecordModel{type: $type, partner: $partner, message: $message, listSymptoms: $listSymptoms, timestamp: $timestamp, date: $dateString}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          partner == other.partner &&
          message == other.message &&
          listSymptoms == other.listSymptoms &&
          timestamp == other.timestamp &&
          dateString == other.dateString;

  @override
  int get hashCode =>
      type.hashCode ^
      partner.hashCode ^
      message.hashCode ^
      listSymptoms.hashCode ^
      timestamp.hashCode ^
      dateString.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'type': type == RecordEnum.symptoms ? 'symptoms' : 'sexualHealth',
      'partner': partner,
      'message': message,
      'listSymptoms': listSymptoms,
      'timestamp': timestamp,
      'date': dateString,
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      type: (map['type'] as String) == 'symptoms' ? RecordEnum.symptoms : RecordEnum.sexualHealth,
      partner: map['partner'] as String,
      message: map['message'] as String,
      listSymptoms: (map['listSymptoms'] as List<dynamic>).cast<String>(),
      timestamp: map['timestamp'] as String,
      dateString: map['date'] as String,
    );
  }
}

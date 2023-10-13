enum TypeRecord {
  sexualAct('Половой акт'),
  symptoms('Симптомы');

  final String title;

  const TypeRecord(this.title);
}

class RecordModel {
  final TypeRecord type;
  final String partner; // Если половой акт
  final String message;
  final List<String> listSymptoms; // Если симптомы
  final String timestamp;

  const RecordModel({
    required this.type,
    required this.partner,
    required this.message,
    required this.listSymptoms,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'RecordModel{type: $type, partner: $partner, message: $message, listSymptoms: $listSymptoms, timestamp: $timestamp}';
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
          timestamp == other.timestamp;

  @override
  int get hashCode => type.hashCode ^ partner.hashCode ^ message.hashCode ^ listSymptoms.hashCode ^ timestamp.hashCode;

  RecordModel copyWith({
    TypeRecord? type,
    String? partner,
    String? message,
    List<String>? listSymptoms,
    String? timestamp,
  }) {
    return RecordModel(
      type: type ?? this.type,
      partner: partner ?? this.partner,
      message: message ?? this.message,
      listSymptoms: listSymptoms ?? this.listSymptoms,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'partner': partner,
      'message': message,
      'listSymptoms': listSymptoms,
      'timestamp': timestamp,
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      type: map['type'] as TypeRecord,
      partner: map['partner'] as String,
      message: map['message'] as String,
      listSymptoms: map['listSymptoms'] as List<String>,
      timestamp: map['timestamp'] as String,
    );
  }
}

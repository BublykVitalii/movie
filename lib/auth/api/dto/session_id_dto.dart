import 'package:json_annotation/json_annotation.dart';

part 'session_id_dto.g.dart';

@JsonSerializable()
class SessionIdDTO {
  @JsonKey(name: 'session_id')
  final String sessionId;

  SessionIdDTO({
    required this.sessionId,
  });

  Map<String, dynamic> toJson() => _$SessionIdDTOToJson(this);

  factory SessionIdDTO.fromJson(Map<String, dynamic> json) =>
      _$SessionIdDTOFromJson(json);

  @override
  String toString() => 'SessionIdDTO(sessionId: $sessionId)';
}

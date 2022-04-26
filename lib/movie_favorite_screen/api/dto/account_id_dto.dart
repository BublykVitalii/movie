import 'package:json_annotation/json_annotation.dart';

part 'account_id_dto.g.dart';

@JsonSerializable()
class AccountIdDTO {
  final int? id;

  AccountIdDTO({
    this.id,
  });

  Map<String, dynamic> toJson() => _$AccountIdDTOToJson(this);

  factory AccountIdDTO.fromJson(Map<String, dynamic> json) =>
      _$AccountIdDTOFromJson(json);

  @override
  String toString() => 'AccountIdDTO(id: $id)';
}

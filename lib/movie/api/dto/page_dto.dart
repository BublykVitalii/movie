import 'package:json_annotation/json_annotation.dart';

part 'page_dto.g.dart';

@JsonSerializable(createFactory: false)
class PageDTO {
  final int page;

  PageDTO({
    required this.page,
  });

  Map<String, dynamic> toJson() => _$PageDTOToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'qr_code.g.dart';

/// The representation of a QRCode entity.
@JsonSerializable()
class QRCode {
  final int id;
  final String name;
  final String brand;

  QRCode(this.id, this.name, this.brand);

  static QRCode fromJson(Map<String, dynamic> json) => _$QRCodeFromJson(json);

  Map<String, dynamic> toJson() => _$QRCodeToJson(this);
}

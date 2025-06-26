import 'package:equatable/equatable.dart';

class ApiFailureModel extends Equatable {
  final String status;
  final int code;
  final String message;

  const ApiFailureModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ApiFailureModel.fromJson(Map<String, dynamic> json) {
    return ApiFailureModel(
      status: json["status"],
      code: json["code"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
  };

  @override
  List<Object?> get props => [status, code, message];
}

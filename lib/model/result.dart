import 'package:equatable/equatable.dart';
import 'service.dart';

class Results extends Equatable {
  final List<Service>? services;

  const Results({this.services});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        services: (json['results'] as List<dynamic>?)
            ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'results': services?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [services];
}
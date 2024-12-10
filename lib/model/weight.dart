import 'package:equatable/equatable.dart';

class Weight extends Equatable {
  final double? value;

  const Weight({this.value}); 

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
    value: (json['value'] as num?)?.toDouble(),
  ); 

  Map<String, dynamic> toJson() => {
    'value': value
  }; 

  @override
  List<Object?> get props => [value]; 

}
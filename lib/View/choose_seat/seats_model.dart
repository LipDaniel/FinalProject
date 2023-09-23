import 'package:equatable/equatable.dart';

class SeatsModel extends Equatable {
  final String? id;

  const SeatsModel({
    this.id,
  });

  @override
  List<Object?> get props => [id];
}

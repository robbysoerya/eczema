import 'package:equatable/equatable.dart';

class GuessNationalityEntity extends Equatable {
  final String? name;
  final List<CountryEntity> country;

  const GuessNationalityEntity({
    required this.name,
    required this.country,
  });

  @override
  List<Object?> get props => [name, country];
}

class CountryEntity extends Equatable {
  final String countryId;
  final double probability;

  const CountryEntity({
    required this.countryId,
    required this.probability,
  });

  @override
  List<Object?> get props => [countryId, probability];
}

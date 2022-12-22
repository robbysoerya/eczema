import 'package:eczema/core/domain/entities/guess_nationality_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guess_nationality_model.g.dart';

@JsonSerializable()
class GuessNationalityModel extends Equatable {
  final String? name;
  final List<CountryModel> country;

  const GuessNationalityModel({
    required this.name,
    required this.country,
  });

  factory GuessNationalityModel.fromJson(Map<String, dynamic> json) =>
      _$GuessNationalityModelFromJson(json);

  Map<String, dynamic> toJson() => _$GuessNationalityModelToJson(this);

  GuessNationalityEntity toEntity() {
    return GuessNationalityEntity(
      name: name,
      country: List.from(country.map((e) => e.toEntity())),
    );
  }

  @override
  List<Object?> get props => [name, country];
}

@JsonSerializable()
class CountryModel extends Equatable {
  final String countryId;
  final double probability;

  const CountryModel({
    required this.countryId,
    required this.probability,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  CountryEntity toEntity() {
    return CountryEntity(
      countryId: countryId,
      probability: probability,
    );
  }

  @override
  List<Object?> get props => [countryId, probability];
}

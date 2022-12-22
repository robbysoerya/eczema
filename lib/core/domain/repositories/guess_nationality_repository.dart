import 'package:dartz/dartz.dart';
import 'package:eczema/core/core.dart';
import 'package:eczema/core/domain/entities/guess_nationality_entity.dart';

abstract class GuessNationalityRepository {
  Future<Either<Failure, GuessNationalityEntity>> getNationality();
}

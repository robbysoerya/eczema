import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eczema/core/core.dart';
import 'package:eczema/core/data/datasources/guess_nationality_remote_data_source.dart';
import 'package:eczema/core/domain/entities/guess_nationality_entity.dart';
import 'package:eczema/core/domain/repositories/guess_nationality_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final guessNationalityRepositoryProvider =
    Provider.autoDispose<GuessNationalityRepository>((ref) {
  ref.onDispose(() {});
  return GuessNationalityRepositoryImpl(
    remoteDataSource: GuessNationalityRemoteDataSourceImpl(
      apiService: ApiService(),
    ),
    networkInfo: NetworkInfoImpl(
      dataConnectionChecker: InternetConnectionChecker(),
    ),
  );
});

class GuessNationalityRepositoryImpl implements GuessNationalityRepository {
  final GuessNationalityRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GuessNationalityRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, GuessNationalityEntity>> getNationality() async {
    if (await networkInfo.isConnected) {
      try {
        final resp = await remoteDataSource.getNationality();
        return Right(resp);
      } on ServerFailure {
        return const Left(ServerFailure(''));
      } on SocketException catch (e) {
        return Left(SocketFailure(e.message));
      }
    } else {
      return const Left(ConnectionFailure('No Internet Connection'));
    }
  }
}

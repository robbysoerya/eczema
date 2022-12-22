import 'package:eczema/core/core.dart';
import 'package:eczema/core/domain/entities/guess_nationality_entity.dart';

abstract class GuessNationalityRemoteDataSource {
  Future<GuessNationalityEntity> getNationality();
}

class GuessNationalityRemoteDataSourceImpl
    implements GuessNationalityRemoteDataSource {
  final ApiService apiService;

  GuessNationalityRemoteDataSourceImpl({required this.apiService});

  @override
  Future<GuessNationalityEntity> getNationality() async {
    final resp = await apiService.getNationality();
    return resp.toEntity();
  }
}

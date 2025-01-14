import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/failure.dart';
import '../../domain/entities/user_entity.dart';
import 'local_constants.dart';
import 'local_datasource.dart';

class LocalAuthRepository {
  final LocalDatasource _localDatasourcesService;
  LocalAuthRepository(this._localDatasourcesService);

  //
  //<<<<<<<<<<<<<<<<<<<<<<<---------ACCESS-TOKEN--------->>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, String?>> getToken() async {
    try {
      var result = await _localDatasourcesService.read(LocalConstants.token);
      if (result != null) {
        Logger().i("Token Found");
        return Right(result);
      }

      return Left(Failure("Token Not Found"));
    } catch (e) {
      Logger().e(e);
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> setToken(String token) async {
    try {
      await _localDatasourcesService.write(
        LocalConstants.token,
        token,
      );
      print("Token saved: $token");
      return const Right(null);
    } on Exception catch (e) {
      Logger().e(e);
      return Left(Failure(e.toString()));
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<<---------USER--------->>>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      var result = await _localDatasourcesService.read(LocalConstants.user);
      if (result != null) {
        return Right(UserEntity.fromJson(result));
      } else {
        return Left(Failure("User Entity Not Found"));
      }
    } catch (e) {
      Logger().e(e);
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, void>> setUser(UserEntity user) async {
    try {
      await _localDatasourcesService.write(
        LocalConstants.user,
        user.toJson(),
      );
      return const Right(null);
    } on Exception catch (e) {
      Logger().e(e);
      return Left(Failure(e.toString()));
    }
  }

  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<---------LOG-OUT--------->>>>>>>>>>>>>>>>>>>>>>>>>>
  //

  Future<void> logout() async {
    await _localDatasourcesService.delete(LocalConstants.user);
    await _localDatasourcesService.delete(LocalConstants.token);
  }
}

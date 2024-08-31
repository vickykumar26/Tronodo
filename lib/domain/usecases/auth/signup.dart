import 'package:dartz/dartz.dart';
import 'package:tronodo/core/usecase/usecase.dart';
import 'package:tronodo/data/models/auth/create_user_req.dart';
import 'package:tronodo/domain/repository/auth/auth.dart';
import 'package:tronodo/service_locator.dart';

class SignupUseCase implements UseCase<Either,CreateUserReq>{

  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

}
import 'package:dartz/dartz.dart';
import 'package:tronodo/core/usecase/usecase.dart';
import 'package:tronodo/data/models/auth/signin_user_req.dart';
import 'package:tronodo/domain/repository/auth/auth.dart';
import 'package:tronodo/service_locator.dart';

import '../../../data/repository/auth/auth_repository_impl.dart';
import '../../entities/auth/user.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{

 @override
 Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }

}
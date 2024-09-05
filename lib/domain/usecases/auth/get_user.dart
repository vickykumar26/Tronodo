import 'package:dartz/dartz.dart';
import 'package:tronodo/core/usecase/usecase.dart';
import 'package:tronodo/domain/repository/auth/auth.dart';
import 'package:tronodo/service_locator.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{

 @override
 Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }

}
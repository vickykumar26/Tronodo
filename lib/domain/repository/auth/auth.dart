import 'package:dartz/dartz.dart';
import 'package:tronodo/data/models/auth/create_user_req.dart';
import 'package:tronodo/data/models/auth/signin_user_req.dart';

import '../../../data/repository/auth/auth_repository_impl.dart';
import '../../entities/auth/user.dart';

abstract class AuthRepository {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();

}
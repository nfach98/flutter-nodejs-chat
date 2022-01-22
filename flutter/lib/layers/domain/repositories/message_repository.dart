import 'package:chat/core/error/failures.dart';
import 'package:chat/layers/domain/entities/message.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> getLocalMessages({required String idUser});

  Future<Either<Failure, int>> addLocalMessage({required String id, String? type, String? idUser, String? message, String? time, bool? isRead});

  Future<Either<Failure, int>> deleteLocalMessage({required String id});
}
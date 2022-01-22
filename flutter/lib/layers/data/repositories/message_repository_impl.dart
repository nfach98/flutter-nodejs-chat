import 'package:chat/core/error/exceptions.dart';
import 'package:chat/core/error/failures.dart';
import 'package:chat/layers/data/sources/local/message_local_data_source.dart';
import 'package:chat/layers/domain/entities/message.dart';
import 'package:chat/layers/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';

typedef _ListMessageLoader = Future<List<Message>> Function();
typedef _IntLoader = Future<int> Function();

class MessageRepositoryImpl extends MessageRepository {
  final MessageLocalDataSource localDataSource;

  MessageRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, int>> addLocalMessage({required String id, String? type, String? idUser, String? message, String? time, bool? isRead}) async {
    return await _getInt(() async {
      return localDataSource.addLocalMessage(
        id: id,
        type: type,
        idUser: idUser,
        message: message,
        time: time,
        isRead: isRead
      );
    });
  }

  @override
  Future<Either<Failure, int>> deleteLocalMessage({required String id}) async {
    return await _getInt(() async {
      return localDataSource.deleteLocalMessage(id: id);
    });
  }

  @override
  Future<Either<Failure, List<Message>>> getLocalMessages({required String idUser}) async {
    return await _getListMessage(() async {
      return localDataSource.getLocalMessages(idUser: idUser);
    });
  }

  Future<Either<Failure, List<Message>>> _getListMessage(_ListMessageLoader getListMessage) async {
    try {
      final local = await getListMessage();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, int>> _getInt(_IntLoader getInt) async {
    try {
      final local = await getInt();
      return Right(local);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
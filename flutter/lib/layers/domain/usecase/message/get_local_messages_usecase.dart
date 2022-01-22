import 'package:chat/core/error/failures.dart';
import 'package:chat/core/usecase/usecase.dart';
import 'package:chat/layers/domain/entities/message.dart';
import 'package:chat/layers/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetLocalMessagesUsecase extends UseCase<List<Message>, GetLocalMessagesParams> {
  final MessageRepository repository;

  GetLocalMessagesUsecase(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(GetLocalMessagesParams params) async {
    return await repository.getLocalMessages(idUser: params.idUser);
  }
}

class GetLocalMessagesParams extends Equatable {
  final String idUser;

  const GetLocalMessagesParams({
    required this.idUser
  });

  @override
  List<Object> get props => [
    idUser,
  ];
}
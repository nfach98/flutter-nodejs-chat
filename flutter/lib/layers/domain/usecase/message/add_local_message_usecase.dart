import 'package:chat/core/error/failures.dart';
import 'package:chat/core/usecase/usecase.dart';
import 'package:chat/layers/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddLocalMessageUsecase extends UseCase<int, AddLocalMessagesParams> {
  final MessageRepository repository;

  AddLocalMessageUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(AddLocalMessagesParams params) async {
    return await repository.addLocalMessage(
      id: params.id,
      type: params.type,
      idUser: params.idUser,
      message: params.message,
      time: params.time,
      isRead: params.isRead
    );
  }
}

class AddLocalMessagesParams extends Equatable {
  final String id;
  final String? type;
  final String? idUser;
  final String? message;
  final String? time;
  final bool? isRead;

  const AddLocalMessagesParams({
    required this.id,
    this.type,
    this.idUser,
    this.message,
    this.time,
    this.isRead,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    idUser,
    message,
    time,
    isRead
  ];
}
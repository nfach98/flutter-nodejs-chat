import 'package:chat/core/error/failures.dart';
import 'package:chat/core/usecase/usecase.dart';
import 'package:chat/layers/domain/repositories/message_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DeleteLocalMessageUsecase extends UseCase<int, DeleteLocalMessageParams> {
  final MessageRepository repository;

  DeleteLocalMessageUsecase(this.repository);

  @override
  Future<Either<Failure, int>> call(DeleteLocalMessageParams params) async {
    return await repository.deleteLocalMessage(id: params.id);
  }
}

class DeleteLocalMessageParams extends Equatable {
  final String id;

  const DeleteLocalMessageParams({
    required this.id
  });

  @override
  List<Object> get props => [
    id,
  ];
}
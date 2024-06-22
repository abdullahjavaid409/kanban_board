import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/application/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params prams);
}

abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

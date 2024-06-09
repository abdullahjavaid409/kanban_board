import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kanban_board/application/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params prams);
}

abstract class UseCased<Type, Params> {
  Future<Either<Failure, Type>> call(Params prams, String educationId);
}

abstract class TwoIntegerWithStringUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(
      Params prams, int perPage, int pageNoString, String date);
}

abstract class FourParameterUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(
      Params prams, String years, String occurrence, String userId, int month);
}

abstract class HomePageStatusUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(
      Params prams, String appointmentId, String status);
}

abstract class HomePageListUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(
      Params prams, int perPage, int pageNoString);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

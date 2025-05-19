part of 'search_ngo_cubit.dart';

@immutable
sealed class SearchNgoState {}

final class SearchNgoInitial extends SearchNgoState {}

final class SearchNgoLoading extends SearchNgoState {}

final class SearchNgoSuccess extends SearchNgoState {
  final List<NgoModel> ngos;

  SearchNgoSuccess({required this.ngos});
}

final class SearchNgoFailure extends SearchNgoState {
  final String message;

  SearchNgoFailure({required this.message});
} 
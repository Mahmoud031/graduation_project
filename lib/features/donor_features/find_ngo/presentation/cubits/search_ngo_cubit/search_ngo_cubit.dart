import 'package:bloc/bloc.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/auth/data/models/ngo_model.dart';
import 'package:meta/meta.dart';

part 'search_ngo_state.dart';

class SearchNgoCubit extends Cubit<SearchNgoState> {
  final DatabaseService databaseService;

  SearchNgoCubit(this.databaseService) : super(SearchNgoInitial());

  Future<void> searchNgos(String query) async {
    if (query.isEmpty) {
      emit(SearchNgoInitial());
      return;
    }

    emit(SearchNgoLoading());
    try {
      final ngoData = await databaseService.getData(
        path: BackendEndpoint.getNgoData,
      ) as List<Map<String, dynamic>>;

      final List<NgoModel> ngos = ngoData
          .map((data) => NgoModel.fromJson(data))
          .where(
              (ngo) => ngo.address.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(SearchNgoSuccess(ngos: ngos));
    } catch (e) {
      emit(SearchNgoFailure(message: e.toString()));
    }
  }
}

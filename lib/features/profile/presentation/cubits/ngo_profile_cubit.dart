import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';

part 'ngo_profile_state.dart';

class NgoProfileCubit extends Cubit<NgoProfileState> {
  final AuthRepo authRepo;

  NgoProfileCubit(this.authRepo) : super(NgoProfileInitial()) {
    loadNgoProfile();
  }

  Future<void> loadNgoProfile() async {
    emit(NgoProfileLoading());
    try {
      final ngo = getNgo(); // Load from local cache after login/edit
      emit(NgoProfileLoaded(ngo));
    } catch (e) {
      emit(NgoProfileError(e.toString()));
    }
  }

   void refreshProfile() {
     loadNgoProfile();
   }
} 
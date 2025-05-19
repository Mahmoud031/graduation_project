import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/core/widgets/custom_app_bar.dart';
import 'package:graduation_project/core/widgets/custom_search_text_field.dart';
import 'package:graduation_project/features/auth/data/models/ngo_model.dart';
import 'package:graduation_project/features/donor_features/find_ngo/presentation/cubits/search_ngo_cubit/search_ngo_cubit.dart';

import 'ngo_info.dart';
import 'ngo_table.dart';
import 'search_states.dart';

class FindNgoViewBody extends StatefulWidget {
  const FindNgoViewBody({super.key});

  @override
  State<FindNgoViewBody> createState() => _FindNgoViewBodyState();
}

class _FindNgoViewBodyState extends State<FindNgoViewBody> {
  bool showNgoInfo = false;
  NgoModel? selectedNgo;

  void toggleNgoInfo(NgoModel ngo) {
    setState(() {
      selectedNgo = ngo;
      showNgoInfo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchNgoCubit(getIt()),
      child: BlocBuilder<SearchNgoCubit, SearchNgoState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Donate Medicine',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Search Location to Find Ngo',
                  style: TextStyles.textstyle25.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: Color(0xFF888888),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomSearchTextField(
                  onChanged: (query) {
                    context.read<SearchNgoCubit>().searchNgos(query);
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                if (state is SearchNgoInitial)
                  SearchStates(
                    isSearching: false,
                    message: 'Start searching for NGOs by entering a location',
                    icon: Icons.search_rounded,
                    iconColor: Colors.grey.shade400,
                  )
                else if (state is SearchNgoLoading)
                  SearchStates(
                    isSearching: true,
                    message: 'Searching for NGOs...',
                    icon: Icons.search_rounded,
                    iconColor: Colors.blue.shade300,
                  )
                else if (state is SearchNgoSuccess)
                  state.ngos.isEmpty
                      ? SearchStates(
                          isSearching: false,
                          message: 'No NGOs found in this location',
                          icon: Icons.location_off_rounded,
                          iconColor: Colors.orange.shade300,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: NGOTable(
                            onViewPressed: toggleNgoInfo,
                            ngos: state.ngos,
                          ),
                        )
                else if (state is SearchNgoFailure)
                  SearchStates(
                    isSearching: false,
                    message: 'Error: ${state.message}',
                    icon: Icons.error_outline_rounded,
                    iconColor: Colors.red.shade300,
                  ),
                if (showNgoInfo && selectedNgo != null) ...[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  NgoInfo(ngo: selectedNgo!),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/helper_functions/build_error_bar.dart';
import 'package:graduation_project/core/helper_functions/get_user.dart';
import 'package:graduation_project/core/services/get_it_service.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_text_styles.dart';
import 'package:graduation_project/features/chatbot/domain/repos/chatbot_repo.dart';
import 'package:graduation_project/features/chatbot/presentation/cubits/chatbot_cubit/chatbot_cubit.dart';
import 'package:graduation_project/features/chatbot/presentation/views/widgets/chatbot_view_body.dart';

class ChatbotView extends StatefulWidget {
  static const String routeName = '/chatbot';
  const ChatbotView({super.key});

  @override
  State<ChatbotView> createState() => _ChatbotViewState();
}

class _ChatbotViewState extends State<ChatbotView> {
  late String _userType;
  late ChatbotCubit _chatbotCubit;

  @override
  void initState() {
    super.initState();
    _initializeUserType();
    _chatbotCubit = ChatbotCubit(getIt<ChatbotRepo>());
    _chatbotCubit.initializeChatbot(_userType);
  }

  @override
  void dispose() {
    _chatbotCubit.close();
    super.dispose();
  }

  void _initializeUserType() {
    dynamic user;
    try {
      user = getUser();
      _userType = user.type != 'NGO' ? 'donor' : 'ngo';
    } catch (_) {
      try {
        user = getNgo();
        _userType = 'ngo';
      } catch (_) {
        _userType = 'donor'; // Default fallback
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatbotCubit,
      child: BlocListener<ChatbotCubit, ChatbotState>(
        listener: (context, state) {
          if (state is ChatbotFailure) {
            buildErrorBar(context, state.message);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.1),
          appBar: AppBar(
            title: Row(
              children: [
                Icon(
                  Icons.smart_toy,
                  color: Colors.blue, 
                ),
                const SizedBox(width: 8),
                Text(
                  'AI Assistant',
                  style: TextStyles.textstyle18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            elevation: 2,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _chatbotCubit.resetChat();
                  _chatbotCubit.initializeChatbot(_userType);
                },
                tooltip: 'Reset Chat',
              ),
            ],
          ),
          body: const ChatbotViewBody(),
        ),
      ),
    );
  }
} 
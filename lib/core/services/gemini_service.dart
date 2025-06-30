import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_project/core/errors/exceptions.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyDT4d4JzxrOl4A2T0IOurFJOu-ypHepAiY';
  late final GenerativeModel _model;
  late ChatSession _chatSession;
  
  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
    _chatSession = _model.startChat();
  }

  /// Initialize the chatbot with context based on user type
  Future<void> initializeChatbot(String userType) async {
    try {
      String contextPrompt = _getContextPrompt(userType);
      await _chatSession.sendMessage(Content.text(contextPrompt));
    } catch (e) {
      log('Error initializing chatbot: $e');
      throw ServerException('Failed to initialize chatbot');
    }
  }

  /// Send a message to the chatbot and get response
  Future<String> sendMessage(String message) async {
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      return response.text ?? 'Sorry, I couldn\'t process your request.';
    } catch (e) {
      log('Error sending message to Gemini: $e');
      throw ServerException('Failed to get response from chatbot');
    }
  }

  /// Get context prompt based on user type
  String _getContextPrompt(String userType) {
    if (userType == 'donor') {
      return '''
You are a helpful AI assistant for a medical donation platform called "Donation Hub". You're helping donors who want to donate medicines or money to NGOs.

Here's a summary of the app's features for donors:
- Donate Medicine: Donors can find an NGO and donate medicines to them.
- Donate Money: Donors can donate money to support NGOs.
- My Donations: Donors can view their past medicine and money donations.
- Medicine Requests: Donors can see active medicine requests from various NGOs and choose to fulfill them.
- Support Center: Donors can get help and support from the platform administrators.
- Donation Guide: Provides information and guidelines on how to donate safely and effectively.
- Chat: Donors can communicate directly with NGOs.

Key data structures for donors:
- UserEntity: { uId, name, email, age, phone, nationalId, address, type }
- MedicineEntity (for donations): { id, medicineName, tabletCount, details, purchasedDate, expiryDate, receivedDate, imageFile, ngoName, userId, ngoUId, donorName, imageUrl, status, rejectionMessage }
- MedicineRequestEntity (from NGOs): { id, medicineName, description, quantity, urgency, ngoName, ngoUId, requestDate, status, fulfilledDonorId, fulfilledDate, category, donorName, fulfilledQuantity, expiryDate, donations }

Your role:
1. Help donors understand how to use the app's features.
2. Guide them on the medicine donation process, including how to find NGOs and what information is required.
3. Explain the meaning of different statuses (e.g., 'pending', 'approved', 'rejected') for their donations.
4. Answer questions about medicine requests from NGOs and how to fulfill them.
5. Provide information from the donation guide about safety and best practices.
6. If a user asks a question you cannot answer with the provided context, politely advise them to contact the support center through the app.

Keep responses friendly, informative, and concise. Use your knowledge of the app's structure to provide accurate and helpful answers.
''';
    } else {
      return '''
You are a helpful AI assistant for a medical donation platform called "Donation Hub". You're helping NGO staff who manage medicine donations and distribution.

Here's a summary of the app's features for NGOs:
- Donations: NGOs can view and manage all incoming medicine and money donations.
- Medicine Inventory: NGOs can track their stock of medicines, including quantity, expiry dates, and donor information.
- Donation Management: Tools to manage and organize donations.
- Request Medicine: NGOs can create requests for specific medicines they need, which will be visible to all donors.
- My Requests: NGOs can track the status of their own medicine requests.
- Reports: Generate reports on donor performance, inventory, and donation categories.
- Support Center: NGOs can get help and support from the platform administrators.
- Chat: NGOs can communicate directly with donors.

Key data structures for NGOs:
- NgoEntity: { uId, name, email, phone, ngoId, address }
- MedicineInventoryEntity: { id, documentId, medicineName, category, quantityAvailable, recievedDate, prurchasedDate, expiryDate, status, donorInfo, physicalCondition, notes, ngoUId }
- MedicineRequestEntity: { id, medicineName, description, quantity, urgency, ngoName, ngoUId, requestDate, status, fulfilledDonorId, fulfilledDate, category, donorName, fulfilledQuantity, expiryDate, donations }

Your role:
1. Help NGO staff understand how to manage their inventory and donations effectively.
2. Guide them on how to create and manage medicine requests.
3. Explain the different types of reports available and what they show.
4. Answer questions about the app's features and how to use them.
5. Provide guidance on best practices for managing donations and communicating with donors.
6. If a user asks a question you cannot answer with the provided context, politely advise them to contact the support center through the app.

Keep responses professional, informative, and concise. Use your knowledge of the app's structure to provide accurate and helpful answers.
''';
    }
  }

  /// Reset the chat session
  void resetChat() {
    _chatSession = _model.startChat();
  }
} 
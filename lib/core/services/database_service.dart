abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId});
  Future<dynamic> getData(
      {required String path,
      String? documentId}); 
  Future<void> updateData(
      {required String path,
      required Map<String, dynamic> data,
      required String documentId});
  Future<void> deleteData({required String path, String documentId});
  
  // Real-time listening methods for chat feature
  Stream<List<Map<String, dynamic>>> listenToCollection(String path);
  Stream<Map<String, dynamic>?> listenToDocument(String path, String documentId);
}

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
  
}

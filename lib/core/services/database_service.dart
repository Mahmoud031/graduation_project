abstract class DatabaseService {
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId});
  Future<dynamic> getData(
      {required String path,
      String? documentId}); // If documentId is null, returns all documents in the collection
}

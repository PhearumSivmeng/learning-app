class ApiResponse<T> {
  T? records;
  String? msg;
  String? status;
  final int currentPage;
  final int lastPage;
  int? count;

  ApiResponse({
    this.currentPage = 1,
    this.lastPage = 1,
    this.records,
    this.msg,
    this.status,
    this.count,
  });
}

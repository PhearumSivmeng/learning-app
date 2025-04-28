class RepoResponse<T> {
  T? records;
  String? msg;
  String? status;
  final int currentPage;
  final int lastPage;

  RepoResponse({
    this.currentPage = 1,
    this.lastPage = 1,
    this.records,
    this.msg,
    this.status,
  });
}
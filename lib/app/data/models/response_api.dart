class ResponseApi<T> {
  final bool success;
  final T data;
  final String? message;

  ResponseApi({required this.data, this.message, required this.success});
}

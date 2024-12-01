import 'package:flutter_mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.notStarted() : status = Status.notStarted;
  ApiResponse.loading() : status = Status.loading;
  // ditambah ini this.data
  ApiResponse.completed(this.data) : status = Status.complited;
  // ini juga ditambah this.message
  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() {
    return "Status: $status \nMessage: $message \nData: $data";
  }
}

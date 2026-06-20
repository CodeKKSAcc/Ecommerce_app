class AppExceptions implements Exception {
  String title, msg;

  AppExceptions({required this.title, required this.msg});

  @override
  String toString() {
    return "$title: $msg";
  }
}

class NoInternetException extends AppExceptions {
  /*String title, msg;

  NoInternetException({required this.title, required this.msg})
    : super(title: title, msg: msg);*/

  // Or :>>>
  NoInternetException({required super.msg})
    : super(
        title: "No Internet",
      ); // Here i predefined the title(As this exception will occur only when internet isn't present),
         // and i will bring the msg from API response with the help of status-code.
}

class BadRequestException extends AppExceptions{
  BadRequestException({required super.msg})
      : super(
    title: "Bad Request",
  );
}

class UnauthorizedException extends AppExceptions{
  UnauthorizedException({required super.msg})
      : super(
    title: "Unauthorized",
  );
}

class InvalidInputException extends AppExceptions{
  InvalidInputException({required super.msg})
      : super(
    title: "Invalid Input",
  );
}

class ServerException extends AppExceptions{
  ServerException({required super.msg})
      : super(
    title: "Internal Server Error",
  );
}

class FetchDataException extends AppExceptions{
  FetchDataException({required super.msg})
      : super(
    title: "Error During Communication",
  );
}

class NotFoundException extends AppExceptions{
  NotFoundException({required super.msg})
      : super(
    title: "Resource Not Found",
  );
}
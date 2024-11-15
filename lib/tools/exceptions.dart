class ServiceException extends GenericException {
  ServiceException(super.cause);
}

class ApiException extends ServiceException {
  ApiException() : super("Servidor retornou um erro.");
  ApiException.status(int code)
      : super("Servidor retornou um erro. (código: $code)");
  ApiException.message(super.message);
}

class GenericException implements Exception {
  GenericException(this.cause);

  String cause;

  @override
  String toString() {
    return "[$runtimeType] $cause";
  }
}

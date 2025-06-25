sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class InvalidApiKeyException extends APIException {
  InvalidApiKeyException() : super('Chave API inválida');
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('Sem conexão com a internet');
}

class CityNotFoundException extends APIException {
  CityNotFoundException() : super('Cidade não encontrada');
}

class UnknownException extends APIException {
  UnknownException() : super('Ocorreu um erro desconhecido');
}

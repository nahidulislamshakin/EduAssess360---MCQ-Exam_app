import 'dart:convert' as dc;
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import '/services/exception_services.dart';

//class for getting JSON data from the api
class ApiServices {
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = dc.jsonDecode(response.body.toString());
        return jsonResponse;
      case 400:
        throw BadRequestException(
          response.body.toString(),
        );
      case 404:
        throw UnAuthorisedException(
          response.body.toString(),
        );
      default:
        throw FetchDataException(
            "${response.statusCode.toString()} Error accused while communicating with server.");
    }
  }

  Future getApiData(String url) async {
    http.Response response;
    dynamic data;
    try {
      response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 10),
          );
      data = returnResponse(response);
    } on io.SocketException {
      throw FetchDataException(": No internet connection");
    }
    return data;
  }
}

Future postApiData(String url, var data) async {
  try {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: dc.jsonEncode(data),
    );
    return response.statusCode;
  } on io.SocketException {
    throw FetchDataException(": No internet connection");
  }

}

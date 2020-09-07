import 'package:dio/dio.dart';

class CovidService {
  final http = Dio(
    BaseOptions(
      receiveTimeout: 1000 * 120,
      connectTimeout: 100 * 120,
      baseUrl: "https://covid-193.p.rapidapi.com",
    ),
  );

  Future<List> fetchStats() async {
    try {
      final res = await http.get(
        "/statistics",
        options: Options(headers: {
          "X-RapidAPI-Host": "covid-193.p.rapidapi.com",
          "X-RapidAPI-Key":
              "ce36a3e0e0mshfa0072e459b01b3p126523jsn646b1bc84783",
        }),
      );
      if (res.data is Map) {
        return res.data["response"] ?? [];
      } else {
        return [];
      }
    } on DioError catch (e) {
      throw {
        "statusCode": e.response.statusCode,
        "data": e?.response?.data ?? {"message": e?.error ?? e}
      };
    }
  }
}

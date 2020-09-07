import 'package:flutter/material.dart';
import 'package:roavapp/models/http/covid_response.dart';
import 'package:roavapp/services/covid_service.dart';

class CovidState {
  static CovidState _instance;
  ValueNotifier<Future<Map<String, List<CovidData>>>> _statsRef =
      ValueNotifier(null);

  final http = CovidService();

  static CovidState get instance {
    if (_instance == null) {
      _instance = CovidState();
    }
    return _instance;
  }

  ValueNotifier<Future<Map<String, List<CovidData>>>> get statsRef {
    if (_statsRef == null || _statsRef.value == null) {
      _statsRef = ValueNotifier(getStats());
    }
    return _statsRef;
  }

  set statsRef(ValueNotifier<Future<Map<String, List<CovidData>>>> future) {
    _statsRef.value = future.value;
  }

  Future<Map<String, List<CovidData>>> getStats() async {
    Map<String, List<CovidData>> _data = {};
    try {
      final stats = await http.fetchStats();
      if (stats.isNotEmpty) {
        stats.forEach(
          (it) {
            final covidData = CovidData.fromJson(it);
            if (_data.containsKey(covidData.continent)) {
              _data[covidData.continent].add(covidData);
            } else {
              _data[covidData.continent] = [covidData];
            }
          },
        );
        return _data;
      }
      return _data;
    } catch (e) {
      throw e;
    }
  }
}

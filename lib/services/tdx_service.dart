import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parking_taichung/models/onstreet_parking_spot.dart';
import 'package:parking_taichung/models/parking_lot.dart';

class TdxService {
  final _clientId = dotenv.env['CLIENT_ID'];
  final _clientSecret = dotenv.env['CLIENT_SECRET'];
  final Dio _dio = Dio();

  String? _token;
  DateTime? _expire;

  Future<String> getToken() async {
    if (_token != null &&
        _expire != null &&
        DateTime.now().isBefore(_expire!)) {
      return _token!;
    }
    final res = await _dio.post(
      "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token",
      data: {
        "grant_type": "client_credentials",
        "client_id": _clientId,
        "client_secret": _clientSecret,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    _token = res.data["access_token"];
    final seconds = int.tryParse(res.data["expires_in"].toString()) ?? 86400;
    _expire = DateTime.now().add(Duration(seconds: seconds - 60));
    return _token!;
  }

  Future<List<dynamic>> fetchTaichungParkingLots() async {
    final token = await getToken();
    final res = await _dio.get(
      "https://tdx.transportdata.tw/api/basic/v1/Parking/OffStreet/ParkingAvailability/City/Taichung?\$format=JSON",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return res.data["ParkingAvailabilities"];
  }

  Future<List<OffStreetCarPark>> fetchNearbyOffStreetCarParks({
    required double latitude,
    required double longitude,
    int distance = 1000,
    int top = 30,
  }) async {
    final token = await getToken();
    final resp = await _dio.get(
      "https://tdx.transportdata.tw/api/advanced/v1/Parking/OffStreet/CarPark/NearBy?",
      queryParameters: {
        r'$spatialFilter': 'nearby($latitude,$longitude,$distance)',
        r'$top': top,
        r'$format': 'JSON',
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final data = resp.data as List;
    final carParks = data.map((e) => OffStreetCarPark.fromJson(e)).toList();
    return carParks;
  }

  Future<List<dynamic>> fetchNearbyOnStreetSpots({
    required double latitude,
    required double longitude,
    int distance = 1000,
    int top = 30,
  }) async {
    final token = await getToken();
    final res = await _dio.get(
      "https://tdx.transportdata.tw/api/advanced/v1/Parking/OnStreet/ParkingSpot/NearBy",
      queryParameters: {
        r'$spatialFilter': 'nearby($latitude,$longitude,$distance)',
        r'$top': top,
        r'$format': 'JSON',
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return res.data;
  }

  // services/tdx_service.dart

  Future<ParkingLot?> fetchParkingLotDetail(String carParkId) async {
    final token = await getToken();
    final res = await _dio.get(
      "https://tdx.transportdata.tw/api/advanced/v1/Parking/OffStreet/ParkingLot/$carParkId",
      queryParameters: {r'$format': 'JSON'},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    // 回傳陣列，取第一個（只會有一筆）
    final data = res.data as List;
    if (data.isNotEmpty) {
      return ParkingLot.fromJson(data[0]);
    }
    return null;
  }

  Future<List<ParkingSegmentAvailability>> fetchParkingSegmentAvailability({
    required String city,
    int top = 30,
  }) async {
    final token = await getToken();
    final resp = await _dio.get(
      "https://tdx.transportdata.tw/api/basic/v1/Parking/OnStreet/ParkingSegmentAvailability/City/$city",
      queryParameters: {r'$top': top, r'$format': 'JSON'},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    // 解析資料陣列
    final dataList =
        (resp.data['CurbParkingSegmentAvailabilities'] as List?) ?? [];
    return dataList.map((e) => ParkingSegmentAvailability.fromJson(e)).toList();
  }

  Future<List<dynamic>> fetchTaichungCurbSpots() async {
    return [];
    final token = await getToken();
    final res = await _dio.get(
      "https://tdx.transportdata.tw/api/basic/v1/Parking/Curb/CurbSpotParkingAvailability/City/Taichung?\$format=JSON",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return res.data["CurbSpotParkingAvailabilities"];
  }
}

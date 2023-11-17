import 'package:dio/dio.dart';

class DioHelper {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.nmc.com.eg/public/api/',));

  static Future<CustomResponse> sendData(String endPoint,String? token,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endPoint, data: data,options: token!=null? Options(
        headers: { "Token":"Bearer $token"},):null);

      return CustomResponse(stauts: true,response: response);
    } on DioException catch (ex) {

      return CustomResponse(stauts: false);
    };
  }

  static final dio_ = Dio(BaseOptions(
      baseUrl: 'https://api.nmc.com.eg/public/api/'),);
  static Future<CustomResponse> getData(String endPoint,String? token,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await dio_.get(endPoint,options: token!=null? Options(
        headers: { "Token":"Bearer $token",'Accept': 'application/json',},):null);

      return CustomResponse(stauts: true,stutesCode: 200, response: response);
    } on DioException catch (ex) {
      return CustomResponse(stauts: false);
    };


  }
}


class CustomResponse {
  final Response? response;
  final bool? stauts;
  final stutesCode;

  CustomResponse({this.response, this.stauts,this.stutesCode});
}
import 'package:dio/dio.dart';

class Net{
  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://note.zps1.cn:3000/', // FIXME
  ));

}
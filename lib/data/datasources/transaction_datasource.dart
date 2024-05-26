import 'dart:async';

import 'package:dio/dio.dart';
import 'package:explora_app/models/member.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:explora_app/models/user.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio(BaseOptions(baseUrl: 'https://mobileapis.manpits.xyz/api'));
final _localStorage = GetStorage();

class TransactionDatasource {
  final _auth = Options(
      headers: {"Authorization": "Bearer ${_localStorage.read("token")}"});

  Future<TransactionData> getTransaction(int? id) async {
    try {
      final response = await _dio.get('/tabungan/$id', options: _auth);
      return TransactionData.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }

  Future getSavings(int id) async {
    final response = await _dio.get('/saldo/$id', options: _auth);
    return response.data;
  }

  Future addTransaction(int memberId, transactionId, amount) async {
    try {
      final response = await _dio.post('/tabungan',
          data: {
            "anggota_id": memberId,
            "trx_id": transactionId,
            "trx_nominal": amount
          },
          options: _auth);

      return response;
    } on DioException catch (e) {
      throw Exception(e.error);
    }
  }
}

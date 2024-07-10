import 'dart:async';

import 'package:dio/dio.dart';
import 'package:explora_app/models/interest.dart';
import 'package:explora_app/models/transaction.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio(BaseOptions(baseUrl: 'https://mobileapis.manpits.xyz/api'));
final _localStorage = GetStorage();

class TransactionDatasource {
  final _auth = Options(
      headers: {"Authorization": "Bearer ${_localStorage.read("token")}"});

  Future<TransactionData> getTransaction(int? id) async {
    final response = await _dio.get('/tabungan/$id', options: _auth);
    return TransactionData.fromJson(response.data);
  }

  Future<Saldo> getSavings(int id) async {
    final response = await _dio.get('/saldo/$id', options: _auth);
    return Saldo.fromJson(response.data);
  }

  Future addTransaction(int memberId, transactionId, amount) async {
    final response = await _dio.post('/tabungan',
        data: {
          "anggota_id": memberId,
          "trx_id": transactionId,
          "trx_nominal": amount
        },
        options: _auth);

    return response;
  }

  Future getBunga() async {
    final response = await _dio.get("/settingbunga", options: _auth);
    if (response.data["data"]["activebunga"] == null) {
      return null;
    }
    return DataBunga.fromJson(response.data);
  }

  Future addBunga(Bunga bunga) async {
    final response = await _dio.post(
      "/addsettingbunga",
      data: {
        "persen": bunga.persen,
        "isaktif": bunga.isActive,
      },
      options: _auth,
    );

    return response;
  }
}

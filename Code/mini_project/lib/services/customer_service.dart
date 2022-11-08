import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_project/models/customer.dart';

class CustomerService {
  List<CustomerModel> customer = [];

  late final Dio _dio;
  static const baseUrl =
      'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer.json';

  CustomerService() {
    _dio = Dio();
  }

  Future<List<CustomerModel>> getCustomer() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.data != null) {
        response.data.forEach((id, value) {
          customer.add(CustomerModel(
              id: id,
              image: value['image'],
              name: value['name'],
              createAt: value['createAt'],
              email: value['email'],
              numberPhone: value['numberPhone'],
              address: value['address'],
              itemProduct: value['itemProduct'],
              totalPrice: value['totalPrice'],
              itemPayNow: value['itemPayNow'],
              payNow: value['payNow'],
              remindDebt: value['remindDebt']));
        });
      }
      return customer;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  Future<String> addCustomer(CustomerModel cust) async {
    try {
      await _dio.post(
        baseUrl,
        data: cust.toMap(),
      );
      return 'Data Berhasil Ditambahkan';
    } on DioError catch (e) {
      return 'Gagal menambah data';
    }
  }

  Future<String> updateCustomer(CustomerModel cust) async {
    try {
      await _dio.patch(
        'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json',
        data: cust.toMap(),
      );
      return 'Berhasil Update Data';
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return 'Gagal Update Data';
    }
  }

  Future<String> updatePayCustomer(CustomerModel cust) async {
    try {
      await _dio.patch(
        'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json',
        data: cust.toMapPay(),
      );
      return 'Pembayaran Berhasil';
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return 'Pembayaran Gagal';
    }
  }

  Future<String> deleteCustomer(CustomerModel cust) async {
    try {
      final response = await _dio.delete(
        'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json',
      );
      return 'Menghapus ${cust.name}';
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return 'Gagal Menghapus';
    }
  }
}

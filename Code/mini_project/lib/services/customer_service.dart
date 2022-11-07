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
            remindDebt: value['remindDebt']
          ));
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

  Future<void> addCustomer(CustomerModel cust) async {
    try {
      await _dio.post(
        baseUrl,
        data: cust.toMap(),
      );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  Future<void> updateCustomer(CustomerModel cust) async {
    try {
      await _dio.patch(
        'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json',
        data: cust.toMap(),
      );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  Future<void> updatePayCustomer(CustomerModel cust) async {
    try {
      await _dio.patch(
        'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json',
        data: cust.toMapPay(),
      );
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }

  Future<void> deleteCustomer(CustomerModel cust) async {
    try {
      await _dio.delete(
          'https://mini-project-7442c-default-rtdb.asia-southeast1.firebasedatabase.app/customer/${cust.id}.json');
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      rethrow;
    }
  }
}

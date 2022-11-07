import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mini_project/models/customer.dart';
import 'package:mini_project/services/customer_service.dart';


class CustomerViewModel extends ChangeNotifier {
  List<CustomerModel> _dataCustomer = [];
  List<CustomerModel> get dataCustomer => _dataCustomer;
  CustomerModel selectById(String id) =>
      _dataCustomer.firstWhere((element) => element.id == id);

  final CustomerService _service = CustomerService();

  Future<void> addCustomer(CustomerModel cust) async {
    try {
      await _service.addCustomer(cust);
      notifyListeners();
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      rethrow;
    }
  }

  Future<void> getCustomer() async {
    try {
      final result = await _service.getCustomer();
      _dataCustomer = result;
      notifyListeners();
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      rethrow;
    }
  }

  Future<void> updateCustomer(CustomerModel cust) async {
    try {
      await _service.updateCustomer(cust);
      _dataCustomer.indexWhere(
        (element) {
          return element.id == cust.id;
        },
      );
      notifyListeners();
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      rethrow;
    }
  }

  Future<void> updatePayCustomer(CustomerModel cust) async {
    try {
      await _service.updatePayCustomer(cust);
      _dataCustomer.indexWhere(
        (element) {
          return element.id == cust.id;
        },
      );
      notifyListeners();
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      rethrow;
    }
  }


  Future<void> deleteCustomer(CustomerModel cust) async {
    try {
      await _service.deleteCustomer(cust);
      _dataCustomer.removeWhere(
        (element) {
          return element.id == cust.id;
        },
      );
      notifyListeners();
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message.toString());
      }
      rethrow;
    }
  }
}

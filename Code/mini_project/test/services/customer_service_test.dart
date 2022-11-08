import 'package:mini_project/models/customer.dart';
import 'package:mini_project/services/customer_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'customer_service_test.mocks.dart';

@GenerateMocks([CustomerService])
void main() {
  group('Customer Services Api', () {
    CustomerService customerApi = MockCustomerService();
    test(('get all customer'), () async {
      when(customerApi.getCustomer()).thenAnswer((_) async => <CustomerModel>[
            CustomerModel(
                image: 'image.png',
                name: 'test',
                email: 'test@gmail.com',
                createAt: '2022-05-02',
                numberPhone: '00000',
                address: 'jl.test',
                itemProduct: 'itemTest',
                totalPrice: '20000'),
          ]);
      var customer = await customerApi.getCustomer();
      expect(customer.isNotEmpty, true);
    });
    test('add customer', () async {
      var dataCustomer = CustomerModel(
        image: 'image1.png',
        name: 'test1',
        email: 'test1@gmail.com',
        createAt: '2022-05-03',
        numberPhone: '00001',
        address: 'jl.test1',
        itemProduct: 'itemTest1',
        totalPrice: '20001',
      );
      when(customerApi.addCustomer(dataCustomer))
          .thenAnswer((realInvocation) async => 'Data Berhasil Ditambahkan');

      var customer = await customerApi.addCustomer(dataCustomer);
      expect(customer == 'Data Berhasil Ditambahkan', true);
    });

    test('delete customer', () async {
      var dataCustomer = CustomerModel(
        image: 'image1.png',
        name: 'test1',
        email: 'test1@gmail.com',
        createAt: '2022-05-03',
        numberPhone: '00001',
        address: 'jl.test1',
        itemProduct: 'itemTest1',
        totalPrice: '20001',
      );
      when(customerApi.deleteCustomer(dataCustomer))
          .thenAnswer((realInvocation) async => 'Delete test1');

      var customer = await customerApi.deleteCustomer(dataCustomer);
      expect(customer == 'Delete test1', true);
    });

    test('update customer', () async {
      var dataCustomer = CustomerModel(
        image: 'image1.png',
        name: 'test1',
        email: 'test1@gmail.com',
        createAt: '2022-05-03',
        numberPhone: '00001',
        address: 'jl.test1',
        itemProduct: 'itemTest1',
        totalPrice: '20001',
      );
      when(customerApi.updateCustomer(dataCustomer))
          .thenAnswer((realInvocation) async => 'Berhasil Update Data');

      var customer = await customerApi.updateCustomer(dataCustomer);
      expect(customer == 'Berhasil Update Data', true);
    });

    test('update pembayaran customer', () async {
      var dataCustomer = CustomerModel(
        payNow: '2000',
        itemPayNow: 'testPembayaran',
        remindDebt: '2000',
      );
      when(customerApi.updatePayCustomer(dataCustomer))
          .thenAnswer((realInvocation) async => 'Pembayaran Berhasil');

      var customer = await customerApi.updatePayCustomer(dataCustomer);
      expect(customer == 'Pembayaran Berhasil', true);
    });
  });
}

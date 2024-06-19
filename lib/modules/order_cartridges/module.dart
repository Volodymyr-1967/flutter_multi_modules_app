import 'package:flutter/material.dart';
import 'presentation/pages/order_cartridges_page.dart';
import 'data/repositories/order_repository.dart';

class OrderCartridgesModule {
  final OrderRepository orderRepository;

  OrderCartridgesModule()
      : orderRepository = OrderRepository(
            baseUrl: 'https://jsonplaceholder.typicode.com/users');

  Widget buildHomePage(BuildContext context) {
    return OrderCartridgesPage(orderRepository: orderRepository);
  }
}

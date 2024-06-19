import 'package:flutter/material.dart';

import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';


class OrderCartridgesPage extends StatelessWidget {
  final OrderRepository orderRepository;

  const OrderCartridgesPage({super.key, required this.orderRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order List:'),
      ),
      body: FutureBuilder<List<Order>>(
        future: orderRepository.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Center(
                    child: Text('id: ${order.id}'),
                  ),
                  subtitle: Column(children: [
                    Text('Name: ${order.name}'),
                    Text('Email: ${order.email}'),
                  ]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

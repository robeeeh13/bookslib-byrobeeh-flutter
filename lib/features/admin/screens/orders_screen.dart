import 'package:bookslib/common/widgets/loader.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/features/account/widgets/single_product.dart';
import 'package:bookslib/features/admin/services/admin_services.dart';
import 'package:bookslib/features/order_details/screens/order_details.dart';
import 'package:bookslib/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailScreen.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 150,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(orderData.products[0].productName),
                          if (orderData.status == 3)
                            const Text(
                              'Pesanan terselesaikan',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalVariables.blueColor,
                              ),
                            ),
                          if (orderData.status != 3)
                            const Text(
                              'Belum terselesaikan',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          SingleProduct(
                            image: orderData.products[0].images[0],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

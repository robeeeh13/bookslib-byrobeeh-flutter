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
        : Scaffold(
            body: GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              // shrinkWrap: true,
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
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 20,
                          child: Text(
                            orderData.receiver,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (orderData.status == 3)
                        const SizedBox(
                          height: 15,
                          child: Text(
                            'Pesanan terselesaikan',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: GlobalVariables.blueColor,
                            ),
                          ),
                        ),
                      if (orderData.status != 3)
                        const SizedBox(
                          height: 15,
                          child: Text(
                            'Belum terselesaikan',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 129,
                        child: SingleProduct(
                          image: orderData.products[0].images[0],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}

import 'package:bookslib/common/widgets/loader.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/features/account/services/account_services.dart';
import 'package:bookslib/features/account/widgets/single_product.dart';
import 'package:bookslib/features/order_details/screens/order_details.dart';
import 'package:bookslib/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text('Pesananmu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text('Lihat Semua',
                        style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                        )),
                  ),
                ],
              ),
              // DISPLAY PESANAN
              Container(
                height: 280,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SingleProduct(
                              image: orders![index].products[0].images[0],
                            ),
                            Text(orders![index].products[0].productName),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

import 'package:bookslib/common/widgets/loader.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/features/account/services/account_services.dart';
import 'package:bookslib/features/order_details/screens/order_details.dart';
import 'package:bookslib/models/order.dart';
import 'package:flutter/material.dart';

class AllUserOrdersScreen extends StatefulWidget {
  const AllUserOrdersScreen({super.key});

  @override
  State<AllUserOrdersScreen> createState() => _AllUserOrdersScreenState();
}

class _AllUserOrdersScreenState extends State<AllUserOrdersScreen> {
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
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return orders == null
        ? const Loader()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                alignment: Alignment.topLeft,
                child: const Text(
                  'Pesananmu',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: queryData.size.height * 0.8,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(left: 15),
                  itemCount: orders!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orders![index],
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 113,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(
                                  orders![index].products[0].images[0],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                              left: 0,
                              top: 5,
                              right: 0,
                            ),
                            child: Text(
                              orders![index].products[0].productName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (orders![index].status == 3)
                            const Text(
                              'Telah selesai',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalVariables.blueColor,
                              ),
                            ),
                          if (orders![index].status == 0)
                            Text(
                              'Pending',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          if (orders![index].status == 1)
                            Text(
                              'Dikirim',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                          if (orders![index].status == 2)
                            Text(
                              'Diterima',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: GlobalVariables.selectedNavBarColor,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

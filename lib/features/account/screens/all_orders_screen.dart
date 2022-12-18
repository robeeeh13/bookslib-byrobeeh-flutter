import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/features/account/widgets/all_user_orders.dart';
import 'package:flutter/material.dart';

class AllOrdersScreen extends StatelessWidget {
  static const String routeName = '/all-orders';
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(58),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradientBlue,
            ),
          ),
          title: const Text(
            'Seluruh Pesanan',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 15),
            AllUserOrdersScreen(),
          ],
        ),
      ),
    );
  }
}

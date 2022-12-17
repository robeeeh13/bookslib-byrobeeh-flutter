import 'package:bookslib/features/account/services/account_services.dart';
import 'package:bookslib/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AccountServices accountServices = AccountServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Pesananmu || Dummy',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller || Dummy',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Keluar',
              onTap: () => accountServices.logOut(context),
            ),
            AccountButton(
              text: 'Kelola Akun',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:bookslib/features/account/services/account_services.dart';
import 'package:bookslib/features/account/widgets/account_button.dart';
import 'package:bookslib/features/account/widgets/manage_account.dart';
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
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Kelola Akun',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ManageAccountScreen.routeName,
                );
              },
            ),
            AccountButton(
              text: 'Keluar',
              onTap: () => accountServices.logOut(context),
            ),
          ],
        ),
      ],
    );
  }
}

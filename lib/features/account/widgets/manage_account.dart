import 'package:bookslib/common/widgets/custom_button.dart';
import 'package:bookslib/common/widgets/custom_textfield_special.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/features/account/services/account_services.dart';
import 'package:bookslib/models/user.dart';
import 'package:bookslib/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

enum ManageAccount {
  changeidentity,
  changepassword,
}

class ManageAccountScreen extends StatefulWidget {
  static const String routeName = '/manage-account';
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  ManageAccount _manageAccount = ManageAccount.changeidentity;
  final _changeIdentityFormKey = GlobalKey<FormState>();
  final _changePasswordFormKey = GlobalKey<FormState>();
  final AccountServices accountServices = AccountServices();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _changePasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _namaController.dispose();
    _changePasswordController.dispose();
    _passwordController.dispose();
  }

  void changeIdentity() {
    if (_changeIdentityFormKey.currentState!.validate()) {
      accountServices.changeUserFullName(
        context: context,
        name: _namaController.text.trim(),
      );
    } else {
      throw Exception('Tolong masukkan nama dengan benar');
    }
  }

  void changePassword(User user) {
    if (_changePasswordFormKey.currentState!.validate()) {
      accountServices.changeUserPassword(
        context: context,
        oldPassword: _passwordController.text.trim(),
        newPassword: _changePasswordController.text.trim(),
      );
    } else {
      throw Exception('Tolong masukkan password dengan benar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
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
            'Kelola Akun',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kelola akun anda',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _manageAccount == ManageAccount.changeidentity
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Ubah Nama',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.selectedNavBarColor,
                    value: ManageAccount.changeidentity,
                    groupValue: _manageAccount,
                    onChanged: (ManageAccount? val) {
                      setState(() {
                        _manageAccount = val!;
                      });
                    },
                  ),
                ),
                if (_manageAccount == ManageAccount.changeidentity)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _changeIdentityFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama lama: ${user.name}'),
                          CustomTextFieldSpecial(
                            controller: _namaController,
                            hintText: 'Masukkan nama baru',
                            icon: const Icon(Icons.person),
                            errorMessage: 'Nama tidak boleh kosong',
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Ubah nama',
                            onTap: changeIdentity,
                            color: const Color.fromARGB(255, 5, 83, 161),
                            textColor: GlobalVariables.backgroundColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _manageAccount == ManageAccount.changepassword
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  title: const Text(
                    'Ubah password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.selectedNavBarColor,
                    value: ManageAccount.changepassword,
                    groupValue: _manageAccount,
                    onChanged: (ManageAccount? val) {
                      setState(() {
                        _manageAccount = val!;
                      });
                    },
                  ),
                ),
                if (_manageAccount == ManageAccount.changepassword)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _changePasswordFormKey,
                      child: Column(
                        children: [
                          CustomTextFieldSpecial(
                            controller: _passwordController,
                            hintText: 'Masukkan password lama',
                            icon: const Icon(Icons.lock_outline_sharp),
                            errorMessage: 'Password lama tidak boleh kosong',
                            obsecureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldSpecial(
                            controller: _changePasswordController,
                            hintText: 'Masukkan password baru',
                            icon: const Icon(Icons.password),
                            errorMessage: 'Password baru tidak boleh kosong',
                            obsecureText: true,
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Ubah password',
                            onTap: () => changePassword(user),
                            color: const Color.fromARGB(255, 5, 83, 161),
                            textColor: GlobalVariables.backgroundColor,
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

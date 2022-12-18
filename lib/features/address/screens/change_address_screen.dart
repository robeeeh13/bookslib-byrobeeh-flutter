import 'package:bookslib/common/widgets/custom_button.dart';
import 'package:bookslib/common/widgets/custom_textfield.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/features/address/services/address_services.dart';
import 'package:bookslib/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeAddressScreen extends StatefulWidget {
  static const String routeName = '/change-address';
  const ChangeAddressScreen({super.key});

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  final _changeAddressFormKey = GlobalKey<FormState>();
  final TextEditingController namaJalanController = TextEditingController();
  final TextEditingController rtRwController = TextEditingController();
  final TextEditingController kecamatanKabKotaController =
      TextEditingController();
  final TextEditingController kodePosController = TextEditingController();
  String newAddress = '';
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    namaJalanController.dispose();
    rtRwController.dispose();
    kecamatanKabKotaController.dispose();
    kodePosController.dispose();
  }

  void changeAddress() {
    newAddress = '';
    if (_changeAddressFormKey.currentState!.validate()) {
      newAddress =
          '${namaJalanController.text}, RT/RW ${rtRwController.text}, ${kecamatanKabKotaController.text}, ${kodePosController.text}';

      addressServices.saveUserAddress(
        context: context,
        address: newAddress,
      );

      showSnackBar(context, 'Alamat berhasil diubah');
    } else {
      throw Exception('Tolong masukkan alamat dengan benar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              if (user.address.isNotEmpty)
                const Text(
                  'Alamat saat ini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 5),
              Column(
                children: [
                  if (user.address.isNotEmpty)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          user.address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 5),
                  const Text(
                    'Masukkan alamat baru',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Form(
                    key: _changeAddressFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: namaJalanController,
                          hintText: 'Nama Jalan dan Nomor Rumah',
                          icon: const Icon(Icons.streetview),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: rtRwController,
                          hintText: 'RT/RW',
                          icon: const Icon(Icons.numbers),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: kecamatanKabKotaController,
                          hintText: 'Kecamatan, Kota/Kabupaten, Provinsi',
                          icon: const Icon(Icons.location_city),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: kodePosController,
                          hintText: 'Kode Pos',
                          icon: const Icon(Icons.local_post_office),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Contoh:  Jl. Otto Iskandardinata No.64C, RT.1/RW.4, Bidara Cina, Kecamatan Jatinegara, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13330',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Ubah Alamat',
                    onTap: changeAddress,
                    color: const Color.fromARGB(255, 5, 83, 161),
                    textColor: GlobalVariables.backgroundColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

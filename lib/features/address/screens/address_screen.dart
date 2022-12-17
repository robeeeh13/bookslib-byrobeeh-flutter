// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookslib/common/widgets/custom_button.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:bookslib/common/widgets/custom_textfield.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/features/search/screens/search_screen.dart';
import 'package:bookslib/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final TextEditingController namaJalanController = TextEditingController();
  final TextEditingController rtRwController = TextEditingController();
  final TextEditingController kecamatanKabKotaController =
      TextEditingController();
  final TextEditingController kodePosController = TextEditingController();

  String addressToBeUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        label: 'Total Harga',
        amount: widget.totalAmount,
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    namaJalanController.dispose();
    rtRwController.dispose();
    kecamatanKabKotaController.dispose();
    kodePosController.dispose();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void payBooks(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = namaJalanController.text.isNotEmpty ||
        rtRwController.text.isNotEmpty ||
        kecamatanKabKotaController.text.isNotEmpty ||
        kodePosController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${namaJalanController.text}, RT/RW ${rtRwController.text}, ${kecamatanKabKotaController.text}, ${kodePosController.text}';
      } else {
        throw Exception('Tolong masukkan alamat dengan benar');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Terjadi kesalahan, silahkan coba lagi');
    }

    addressServices.saveUserAddress(
      context: context,
      address: addressToBeUsed,
    );

    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
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
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Atau',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
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
              CustomButton(text: 'Bayar', onTap: () => payBooks(address)),
            ],
          ),
        ),
      ),
    );
  }
}

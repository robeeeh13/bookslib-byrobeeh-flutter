import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // TEMPORARY LIST DELETE THIS LATER
  List list = [
    'https://media.istockphoto.com/id/1412583468/id/foto/konsep-studi-dan-pendidikan-buku-musim-gugur-kembali-ke-sekolah-buku-halloween-bacaan-musim.jpg?s=612x612&w=0&k=20&c=XpxVCk8JfClcTeeiiWD_z49rewdthuqkOGDN8_gdg_c=',
    'https://media.istockphoto.com/id/1412583468/id/foto/konsep-studi-dan-pendidikan-buku-musim-gugur-kembali-ke-sekolah-buku-halloween-bacaan-musim.jpg?s=612x612&w=0&k=20&c=XpxVCk8JfClcTeeiiWD_z49rewdthuqkOGDN8_gdg_c=',
    'https://media.istockphoto.com/id/1412583468/id/foto/konsep-studi-dan-pendidikan-buku-musim-gugur-kembali-ke-sekolah-buku-halloween-bacaan-musim.jpg?s=612x612&w=0&k=20&c=XpxVCk8JfClcTeeiiWD_z49rewdthuqkOGDN8_gdg_c=',
    'https://media.istockphoto.com/id/1412583468/id/foto/konsep-studi-dan-pendidikan-buku-musim-gugur-kembali-ke-sekolah-buku-halloween-bacaan-musim.jpg?s=612x612&w=0&k=20&c=XpxVCk8JfClcTeeiiWD_z49rewdthuqkOGDN8_gdg_c=',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                image: list[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

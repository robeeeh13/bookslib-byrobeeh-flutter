import 'dart:io';

import 'package:bookslib/common/widgets/custom_button.dart';
import 'package:bookslib/common/widgets/custom_textfield.dart';
import 'package:bookslib/common/widgets/custom_textfieldExtra.dart';
import 'package:bookslib/constants/global_variables.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add_product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController publisherController = TextEditingController();
  final TextEditingController yearPublishedController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Novel';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    authorNameController.dispose();
    publisherController.dispose();
    yearPublishedController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    genreController.dispose();
  }

  List<String> productCategories = [
    'Novel',
    'Majalah',
    'Kamus',
    'Komik',
    'Manga',
    'Ensiklopedia',
    'Biografi'
  ];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        productName: productNameController.text,
        authorName: authorNameController.text,
        publisher: publisherController.text,
        yearPublished: yearPublishedController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        genre: genreController.text,
        category: category,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
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
            'Tambah Produk',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open, size: 40),
                                const SizedBox(height: 15),
                                Text(
                                  'Pilih gambar produk',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Nama produk',
                  icon: const Icon(Icons.library_books),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: authorNameController,
                  hintText: 'Nama penulis',
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: publisherController,
                  hintText: 'Penerbit',
                  icon: const Icon(Icons.local_library),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: genreController,
                  hintText: 'Genre',
                  icon: const Icon(Icons.category),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: yearPublishedController,
                  hintText: 'Tahun terbit',
                  icon: const Icon(Icons.calendar_month),
                ),
                const SizedBox(height: 10),
                CustomTextFieldExtra(
                  controller: descriptionController,
                  hintText: 'Sinopsis',
                  icon: const Icon(Icons.description_outlined),
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Harga',
                  icon: const Icon(Icons.price_change_outlined),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                  icon: const Icon(Icons.production_quantity_limits),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Tambah',
                  onTap: sellProduct,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

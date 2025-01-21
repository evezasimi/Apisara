import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ShowProduct.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: addproduct(),
    );
  }
}

class addproduct extends StatefulWidget {
  @override
  State<addproduct> createState() => _AddProductState();
}

class _AddProductState extends State<addproduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController productidController = TextEditingController();
  final category = ['Electronics', 'Clothing', 'Food', 'Books'];
  String? selectedCategory;

  DateTime? productionDate;

  Future<void> pickProductionDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: productionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        productionDate = pickedDate;
        dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> saveProductToDatabase() async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref('products');
      Map<String, dynamic> productData = {
        'name': nameController.text,
        'description': desController.text,
        'category': selectedCategory,
        'productionDate': productionDate?.toIso8601String(),
        'price': double.parse(priceController.text),
        'quantity': int.parse(quantityController.text),
      };
      await dbRef.push().set(productData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('บันทึกข้อมูลสำเร็จ')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowProduct(),
        ),
      );

      _formKey.currentState?.reset();
      nameController.clear();
      desController.clear();
      priceController.clear();
      quantityController.clear();
      dateController.clear();
      setState(() {
        selectedCategory = null;
        productionDate = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'เพิ่มข้อมูลสินค้า',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 156, 168),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ข้อมูลสินค้า',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: _inputDecoration('ชื่อสินค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อสินค้า';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: desController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'รายละเอียดสินค้า',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกรายละเอียดสินค้า';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: _inputDecoration('ประเภทสินค้า'),
                  items: category.map((category) {
                    IconData iconData;
                    // กำหนดไอคอนสำหรับแต่ละประเภทสินค้า
                    switch (category) {
                      case 'Electronics':
                        iconData = Icons.devices;
                        break;
                      case 'Clothing':
                        iconData = Icons.checkroom;
                        break;
                      case 'Food':
                        iconData = Icons.fastfood;
                        break;
                      case 'Books':
                        iconData = Icons.book;
                        break;
                      default:
                        iconData = Icons.category;
                    }
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(iconData,
                              size: 20, color: Colors.grey), // ไอคอนของประเภท
                          SizedBox(width: 10),
                          Text(category), // ชื่อประเภท
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => selectedCategory = value),
                  validator: (value) {
                    if (value == null) return 'กรุณาเลือกประเภทสินค้า';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: _inputDecoration('วันที่ผลิต').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => pickProductionDate(context),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('ราคาสินค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกราคาสินค้า';
                    }
                    if (double.tryParse(value) == null) {
                      return 'กรุณากรอกราคาเป็นตัวเลข';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('จำนวนสินค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกจำนวนสินค้า';
                    }
                    if (int.tryParse(value) == null) {
                      return 'กรุณากรอกจำนวนเป็นตัวเลข';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        saveProductToDatabase();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 236, 156, 168),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'บันทึกสินค้า',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onlinedb_apisara/showproducttype.dart';
import 'addproduct.dart';
import 'ShowProduct.dart';
import 'showproducttype.dart';
import 'showproductgrid.dart';

//Method หลักทีRun
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBTC2j_azkGF5-0u5ufEhZzyGZX-lrP8tc",
            authDomain: "onlinefirebase-f38fc.firebaseapp.com",
            databaseURL:
                "https://onlinefirebase-f38fc-default-rtdb.firebaseio.com",
            projectId: "onlinefirebase-f38fc",
            storageBucket: "onlinefirebase-f38fc.firebasestorage.app",
            messagingSenderId: "481082150882",
            appId: "1:481082150882:web:f0806cf40d1715e27273bb",
            measurementId: "G-9DXX1LEEGL"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

//Class stateless สั่งแสดงผลหนาจอ
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 144, 209)),
        useMaterial3: true,
      ),
      home: Main(),
    );
  }
}

//Class stateful เรียกใช้การทํางานแบบโต้ตอบ
class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apisara Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 156, 168),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png', 
                    height: 200, 
                    width: 200, 
                  ),
                  SizedBox(height: 15), 
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => addproduct(),
                        ),
                      );
                    },
                    icon: Icon(Icons.inventory_2, color: Colors.white),
                    label: Text(
                      'จัดการข้อมูลสินค้า',
                      style: TextStyle(
                        color: Colors.white, // สีข้อความ
                        fontSize: 20, // ขนาดตัวอักษร
                        fontFamily: 'Roboto', // ใช้ฟอนต์ที่กำหนด
                        fontWeight: FontWeight.bold, // ทำตัวหนา
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 165, 233, 246), // สีพื้นหลังของปุ่ม
                      foregroundColor: Colors.white, // สีข้อความในปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // มุมโค้งของปุ่ม
                        side: BorderSide(
                          color: Colors.white, // สีกรอบของปุ่ม
                          width: 2, // ความหนาของกรอบ
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32), // ขนาดปุ่ม
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // ปุ่ม "จัดการข้อมูลสถานที่จำหน่าย"
                  ElevatedButton.icon(
                    onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => showproductgrid(),
                        ),
                      );},
                      icon: Icon(Icons.store_mall_directory, color: Colors.white),
                    label: Text(
                      'แสดงข้อมูลสินค้า',
                      style: TextStyle(
                        color: Colors.white, // สีข้อความ
                        fontSize: 20, // ขนาดตัวอักษร
                        fontFamily: 'Roboto', // ใช้ฟอนต์ที่กำหนด
                        fontWeight: FontWeight.bold, // ทำตัวหนา
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 245, 172, 183), // สีพื้นหลังของปุ่ม
                      foregroundColor: Colors.white, // สีข้อความในปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // มุมโค้งของปุ่ม
                        side: BorderSide(
                          color: Colors.white, // สีกรอบของปุ่ม
                          width: 2, // ความหนาของกรอบ
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32), // ขนาดปุ่ม
                    ),
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  // ปุ่ม "จัดการข้อมูลสถานที่จำหน่าย"
                  ElevatedButton.icon(
                    onPressed: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => showproducttype(),
                        ),
                      );},
                      icon: Icon(Icons.category, color: Colors.white),
                    label: Text(
                      'ประเภทสินค้า',
                      style: TextStyle(
                        color: Colors.white, // สีข้อความ
                        fontSize: 20, // ขนาดตัวอักษร
                        fontFamily: 'Roboto', // ใช้ฟอนต์ที่กำหนด
                        fontWeight: FontWeight.bold, // ทำตัวหนา
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 219, 139, 233), // สีพื้นหลังของปุ่ม
                      foregroundColor: Colors.white, // สีข้อความในปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // มุมโค้งของปุ่ม
                        side: BorderSide(
                          color: Colors.white, // สีกรอบของปุ่ม
                          width: 2, // ความหนาของกรอบ
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32), // ขนาดปุ่ม
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

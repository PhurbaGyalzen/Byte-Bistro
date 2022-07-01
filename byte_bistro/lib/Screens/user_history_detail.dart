import 'package:byte_bistro/Screens/folder_clipper_invoice.dart';
import 'package:byte_bistro/Screens/invoice_clipper.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Color defaultColor = Color(0XFF835454);

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late Uint8List _imageFile;

  // ScreenshotController screenshotController = ScreenshotController();

  

  Future getPdf() async {
    // await screenshotController.capture().then((Uint8List? image) {
    //   //Capture Done
    //   setState(() {
    //     _imageFile = image!;
    //   });
    // }).catchError((onError) {
    //   print(onError);
    // });

    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Expanded(
              child: pw.Image(
            pw.MemoryImage(_imageFile),
            
          
          
          ));
        },
      ),
    );

    // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
    final output = await getExternalStorageDirectory();
    final filePath = "${output?.path}/invoice.pdf";
    final file = File(filePath);
    print("file printed hehehe");
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(filePath);

    // floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       getPdf();
    
    //       print("Download button pressed");
    //     },
    //     backgroundColor: Colors.green,
    //     child: const Icon(Icons.download),
    //   ),
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Order Detail"),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hi"),),
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hi"),),
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hello"),),
            Container(height: 100,child: Text("hello"),)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getPdf();
    
          print("Download button pressed");
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.download),
      ),
    );
  }

  
}

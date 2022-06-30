import 'dart:convert';
import 'dart:io';
import 'package:byte_bistro/constants/colors.dart';
import 'package:byte_bistro/controller/cart_controller.dart';
import 'package:byte_bistro/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  final PageController? pageController;
  const QrScannerScreen({Key? key, this.pageController}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  CartController cartController = Get.find();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderWidth: 10, borderColor: Colors.blueGrey),
              ),
            ),
            Positioned(child: buildControlButtons(), top: 15, right: 140),
            Positioned(
                bottom: 30,
                child: Center(
                  child: (result != null)
                      ? Text('Scanning',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white10))
                      : Text('Scan a code',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          )),
                ))
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        final data = json.decode(result!.code ?? '{}');
        // print(data);
        final table = data['tableNumber'].toString();
        // print('Table: $table');

        controller.dispose();
        Get.offAllNamed('/home');
        cartController.tableNumber.value = int.parse(table);
        Get.snackbar(
          "Table Scanned Sucessfully",
          "Your Table Number is: $table",
          icon: Icon(Icons.error, color: Colors.white),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          animationDuration: Duration(seconds: 1),
          dismissDirection: DismissDirection.horizontal,
          snackPosition: SnackPosition.TOP,
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(
          left: 230,
          top: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder<bool?>(
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off,
                        color: snapshot.data! ? kPrimary : Colors.white,
                      );
                    } else {
                      return Icon(Icons.flash_off, color: Colors.white);
                    }
                  },
                  future: controller?.getFlashStatus(),
                )),
            IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
                icon: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                      );
                    } else {
                      return Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                      );
                    }
                  },
                  future: controller?.getCameraInfo(),
                )),
          ],
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      );
}

// import 'package:byte_bistro/Screens/folder_clipper_invoice.dart';
// import 'package:byte_bistro/Screens/invoice_clipper.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Color defaultColor = Color(0XFF835454);

class UserInvoiceDetail extends StatefulWidget {
  const UserInvoiceDetail({Key? key}) : super(key: key);

  @override
  State<UserInvoiceDetail> createState() => _UserInvoiceDetail();
}

class _UserInvoiceDetail extends State<UserInvoiceDetail> {
  // late Uint8List _imageFile;

  // ScreenshotController screenshotController = ScreenshotController();
  List data = [
    {"name": "Sanjib Limbu"}
  ];

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
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            //header
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  data[0]["name"],
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.5,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text(
                  "Invoice Id 31234567890",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.5,
                    color: PdfColors.black,
                  ),
                ),
                pw.Text(
                  "Invoice Date 2022-3-23",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.normal,
                    height: 1.5,
                    color: PdfColors.black,
                  ),
                ),
              ],
            ),
            //header ended
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder
                  .all(), // Allows to add a border decoration around your table
              children: [
                pw.TableRow(
                  children: [
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        color: PdfColors.grey,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('ITEM'),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        color: PdfColors.grey,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('RATE'),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        color: PdfColors.grey,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('QTY'),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        color: PdfColors.grey,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('AMOUNT'),
                        ),
                      ),
                    ),
                  ],
                ),
                for (var i = 0; i < 5; i++)
                  pw.TableRow(
                    children: [
                      pw.Expanded(
                        flex: 6,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('CHiekcn MOMO'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('Rs. 160'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('2'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('Rs. 320'),
                        ),
                      ),
                    ],
                  ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('TOTAL'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 320'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('SUBTOTAL'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 320'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('TAX@13%'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 50'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('DISCOUNT'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 50'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('TOTAL'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 500'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]; // Center
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // action button
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              getPdf();
            },
          ),
        ],
        title: const Text(
          "Invoice Detail",
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 27,
                right: 27,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       "Invoice",
                  //       style: Theme.of(context).textTheme.headline1,
                  //     ),
                  //     Image.asset(
                  //       "assets/images/splash.png",
                  //       height: 60,
                  //       width: 60,
                  //       fit: BoxFit.fill,
                  //     )
                  //   ],
                  // ),

                  Text(
                    "Sanjib Limbu",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text("Invoice Id 31234567890"),
                  Text("Invoice Date 2022-3-23"),

                  Container(
                    color: Colors.grey,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          flex: 5,
                          child: Text(
                            "ITEM",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "RATE",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "QTY",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "AMOUNT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  "Chicken MOMO Chicken MOMO",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 160",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 320",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  Column(
                    children: [
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              flex: 9,
                              child: Text(
                                "TOTAL",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 320",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Spacer(flex: 5),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "SUBTOTAL",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 320",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Spacer(flex: 5),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "TAX@13%",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 50 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Spacer(flex: 5),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "DISCOUNT",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 50",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Spacer(
                              flex: 5,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "TOTAL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. 500",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     getPdf();

      //     print("Download button pressed");
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.download),
      // )
    );
  }
}

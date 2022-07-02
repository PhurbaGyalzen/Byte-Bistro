// import 'package:byte_bistro/Screens/folder_clipper_invoice.dart';
// import 'package:byte_bistro/Screens/invoice_clipper.dart';
import 'package:byte_bistro/models/user_invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart ' as pw;

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../controller/logged_user_info_controller.dart';

Color defaultColor = Color(0XFF835454);

class UserInvoiceDetail extends StatefulWidget {
  final num totalPrice;
  final UserInvoiceModel data;
  const UserInvoiceDetail(
      {Key? key, required this.totalPrice, required this.data})
      : super(key: key);

  @override
  State<UserInvoiceDetail> createState() => _UserInvoiceDetail();
}

class _UserInvoiceDetail extends State<UserInvoiceDetail> {
  LoggedUserInfoController userLoggedController =
      Get.put(LoggedUserInfoController());

  late int length = widget.data.items.length;
  late int tax = (widget.totalPrice * (13 / 100)).toInt();

  Future getPdf() async {
    pw.Document pdf = pw.Document();
    // final image = pw.MemoryImage(
    //   File('assets/images/splashimage.png').readAsBytesSync(),
    // );
    final image2 = pw.MemoryImage(
      (await rootBundle.load('assets/images/logopdf3.png'))
          .buffer
          .asUint8List(),
    );
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
                pw.Center(
                  child: pw.Image(
                    image2,
                    height: 150,
                    width: 300,
                    fit: pw.BoxFit.fill,
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(bottom: 20),
                  child: pw.Center(
                    child: pw.Text(
                      "INVOICE",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(top: 10),
                    child: pw.Text(
                      "CUSTOMER NAME: ${userLoggedController.userInfo[0].username.toString().toUpperCase()}",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        height: 1.5,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(top: 10),
                    child: pw.Text(
                      "INVOICE NO.: ${widget.data.id}",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        height: 1.5,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Padding(
                    padding: pw.EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    child: pw.Text(
                      "INVOICE DATE: ${widget.data.createdAt}",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.normal,
                        height: 1.5,
                        color: PdfColors.black,
                      ),
                    ),
                  ),
                )
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
                for (var i = 0; i < length; i++)
                  pw.TableRow(
                    children: [
                      pw.Expanded(
                        flex: 6,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(widget.data.items[i].foodId.name
                              .toString()
                              .substring(5)),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(
                              'Rs. ${widget.data.items[i].foodId.price}'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text('${widget.data.items[i].qty}'),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(5),
                          child: pw.Text(
                              'Rs. ${widget.data.items[i].foodId.price * widget.data.items[i].qty}'),
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
                        child: pw.Text('NET TOTAL'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. ${widget.totalPrice}'),
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
                        child: pw.Text('VAT(13%)'),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. $tax'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('DISCOUNT'),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. 0'),
                      ),
                    ),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.SizedBox(),
                    pw.SizedBox(),
                    pw.Container(
                      color: PdfColors.grey,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('G. TOTAL'),
                      ),
                    ),
                    
                    pw.Container(
                      color: PdfColors.grey,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Text('Rs. ${widget.totalPrice + tax}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 70, bottom: 15),
              child: pw.Center(
                child: pw.Text(
                  "Thank you for visting Byte Bistro.",
                  style: pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 0),
              child: pw.Center(
                child: pw.Text(
                  "Corporate Office, Trade Tower Nepal, Thapathali, Kathmandu",
                  style: pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.only(top: 10),
              child: pw.Center(
                child: pw.Text(
                  "@Byte Bistro",
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            )
          ]; // Center
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final filePath = "${output?.path}/invoice.pdf";
    final file = File(filePath);
    print("file printed hehehe");
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(filePath);
  }

  @override
  Widget build(BuildContext context) {
    print("widget.data ${widget.data}");
    print("widget.totalPrice ${widget.totalPrice}");
    var tax = (widget.totalPrice * (13 / 100)).toInt();
    String date1 = widget.data.createdAt.toString();
    date1 = date1.split(" ")[0];
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
                left: 15,
                right: 15,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "CUSTOMER NAME: ",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          userLoggedController.userInfo[0].username
                              .toString()
                              .toUpperCase(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Text("INVOICE ID: ",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Text(widget.data.id)
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        children: [
                          Text("INVOICE DATE: ",
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          Text(date1)
                        ],
                      )),
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
                    itemCount: widget.data.items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  widget.data.items[index].foodId.name
                                      .toString()
                                      .substring(5),
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
                                "Rs. ${widget.data.items[index].foodId.price.toString()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                widget.data.items[index].qty.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. ${widget.data.items[index].foodId.price * widget.data.items[index].qty}",
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
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(flex: 5),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "NET TOTAL",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. ${widget.totalPrice}",
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
                          children: [
                            Spacer(flex: 5),
                            // Expanded(
                            //   flex: 7,
                            //   child: SizedBox(),),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "VAT(13%)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. $tax",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 5),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: const [
                      //       Spacer(flex: 5),
                      //       // Expanded(
                      //       //   flex: 7,
                      //       //   child: SizedBox(),),
                      //       Expanded(
                      //         flex: 3,
                      //         child: Text(
                      //           "DISCOUNT",
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 2,
                      //         child: Text(
                      //           "Rs. 0",
                      //           style: TextStyle(
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        color: Colors.grey,
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(
                              flex: 5,
                            ),

                            Expanded(
                              flex: 3,
                              child: Text(
                                "GRAND TOTAL",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Text(
                                "Rs. ${widget.totalPrice + tax}",
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
    );
  }
}

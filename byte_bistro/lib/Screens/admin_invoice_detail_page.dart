import 'package:byte_bistro/Screens/folder_clipper_invoice.dart';
import 'package:byte_bistro/Screens/invoice_clipper.dart';
import 'package:flutter/material.dart';

Color defaultColor = Color(0XFF835454);

class InvoiceDetail extends StatefulWidget {
  const InvoiceDetail({Key? key}) : super(key: key);

  @override
  State<InvoiceDetail> createState() => _InvoiceDetailState();
}

class _InvoiceDetailState extends State<InvoiceDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Invoice Overview"),
      ),
      body: ClipPath(
        clipper: FolderClipper(),
        child: Container(
          color: const Color(0XFFEAE7EA),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              PhysicalModel(
                color: Colors.transparent,
                elevation: 32,
                shadowColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: _buildContent(context),
                ),
              ),
              Expanded(child: const SizedBox.shrink()),
              _buildActionButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Invoice For",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "Sanjib Limbu",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: defaultColor,
                    ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Amount",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "Rs. 710",
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: defaultColor,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: InvoiceHeaderClipper(),
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 100,
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: Colors.black54,
                ),
                Text(
                  "Invoice",
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: InvoiceContentClipper(),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.file_copy,
                      color: defaultColor,
                    ),
                    Text(
                      "Invoice Details",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: defaultColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                _buildContentInfo(context),
                Container(
                  width: double.infinity,
                  height: .5,
                  color: Colors.black38,
                  margin: EdgeInsets.symmetric(vertical: 12),
                ),
                _buildContentBody(context),
                Container(
                  width: double.infinity,
                  height: .5,
                  color: Colors.black38,
                  margin: EdgeInsets.symmetric(vertical: 24),
                ),
                _buildContentSummary(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContentInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Client's Email",
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Sanjib@gmail.com",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor),
              )
            ],
          ),
        ),
        Container(
          width: .5,
          color: Colors.black38,
          height: 32,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Invoice Date",
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "21 April, 2022",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: defaultColor),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContentBody(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Item",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Price",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pizza",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Rs. 430",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Chicken Biryani",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Rs. 280",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SUbtotal",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Rs. 710",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Discount",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Rs. 50",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total amount",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Rs. 660",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.blueAccent,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      children: [
        // Expanded(
        //   flex: 2,
        //   child: TextButton.icon(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.edit,
        //       color: defaultColor,
        //     ),
        //     label: Text(
        //       "Download",
        //       style: TextStyle(
        //         color: defaultColor,
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          // flex: 3,
          child: Container(
            color: Colors.orangeAccent,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Download",
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:byte_bistro/Screens/folder_clipper_invoice.dart';
import 'package:byte_bistro/Screens/invoice_clipper.dart';
import 'package:flutter/material.dart';

Color defaultColor = Color(0XFF835454);

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
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
        title: const Text("Order Detail"),
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
                "Order For",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "Nishan Thapa",
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
                "Rs. 1000",
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
                  "Order",
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
                      "Order Details",
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
                  "Order Date",
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
            Container(
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
              "Pasta",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            Container(
              width: 100,
              child: Text(
                "Rs. 500",
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
              "Chicken MoMo",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            Container(
              width: 100,
              child: Text(
                "Rs. 500",
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
            Container(
              width: 100,
              child: Text(
                "Rs. 1000",
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
            Container(
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
            Container(
              width: 100,
              child: Text(
                "Rs. 950",
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
        Expanded(
          flex: 2,
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: defaultColor,
            ),
            label: Text(
              "Edit",
              style: TextStyle(
                color: defaultColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.orangeAccent,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Send Invoice",
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
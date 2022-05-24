import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class PromoSearchBox extends StatelessWidget {
  const PromoSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              cursorColor: kPrimary,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hoverColor: kPrimary,
                hintText: 'Promo code',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                prefixIcon: Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    top: 4,
                    bottom: 4,
                    right: 8,
                  ),
                  child: Image(
                      image: AssetImage('assets/images/promoCode.png'),
                      width: 5,
                      height: 5,
                      color: kTextColor.withOpacity(0.5)),
                ),
                prefixIconConstraints:
                    BoxConstraints.expand(width: 40, height: 40),
                suffixIcon: SizedBox(
                  height: 50,
                  width: 80,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: FloatingActionButton(
                        clipBehavior: Clip.hardEdge,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: kTextColor,
                        onPressed: () {},
                        child: Text(
                          'Apply',
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kTextColor),
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

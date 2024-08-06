import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

enum TaxiType {
  sedan,
  van
}

class FixedPriceItemButtonCustom extends StatelessWidget {

  final Function() onTap;
  final TaxiType taxiType;
  final int price;
  final int passengersNumber;
  final bool? selected;
  const FixedPriceItemButtonCustom({super.key, required this.onTap, required this.taxiType, required this.price, required this.passengersNumber, this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeData.s4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(SizeData.s8),
          margin: EdgeInsets.all(SizeData.s2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeData.s8),
            color: selected != null  && selected! ? ColorData.blueColor50 : null,
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: SizeData.s4),
                  child: Image.asset(
                    taxiType == TaxiType.sedan? Assets.bookTaxiSedan : Assets.bookTaxiVan,
                    width: Unit(context).width(SizeData.s73),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taxiType == TaxiType.sedan? LocaleKeys.kSedan.tr() : LocaleKeys.kVan.tr(),
                      style: StyleData.textStyleGray600M14,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${passengersNumber} ${LocaleKeys.kPassengers.tr()}',
                      style: StyleData.textStyleGray600R14,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${price}€',
                      style: StyleData.textStyleGray600SB16,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      ' ',
                      style: StyleData.textStyleGray600R14,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

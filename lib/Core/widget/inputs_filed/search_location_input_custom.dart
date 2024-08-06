import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/generated/assets.dart';

class SearchGoogleInputCustom extends StatelessWidget {
  final TextEditingController addressController;
  final String hintText;
  void Function(Prediction)? getPlaceDetailWithLatLng;
  final bool isCrossBtnShown;
  SearchGoogleInputCustom({Key? key, required this.addressController, required this.hintText,this.getPlaceDetailWithLatLng, this.isCrossBtnShown = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
      showError: true,
      boxDecoration: const BoxDecoration(),
      textEditingController: addressController,
      googleAPIKey: 'AIzaSyDAqZY75SGfTJgzPNZJ_JAQSn_RrS4WWFE',
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorData.grayColor200, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorData.grayColor200, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorData.dangerColor400, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorData.primaryColor700, width: 1.0),
        ),
        contentPadding:EdgeInsets.symmetric(vertical: SizeData.s10,horizontal: SizeData.s20),
        prefixIconConstraints: const BoxConstraints(maxWidth: 44),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeData.s8),
          child: SvgPicture.asset(
            Assets.userLocationIcon,
            height: Unit(context).getWidthSize*0.064,
            width: Unit(context).getWidthSize*0.064,
            color: ColorData.primaryColor600,
            fit: BoxFit.scaleDown,
          ),
        ),
        hintText: hintText,
        hintStyle: StyleData.textStyleGray400M12.copyWith(
            fontSize: Unit(context).getWidthSize*0.037,
            color: ColorData.grayColor400
        ),),
      debounceTime: 800,
      countries: const ["fr", "ch"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
      itemClick: (Prediction prediction) {
        //print(prediction.description.toString());
        addressController.text = prediction.description.toString();
        addressController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length??0));
        addressController.text=prediction.description.toString();
      },
      itemBuilder: (context, index, Prediction prediction) {
        if (prediction.types!.contains("country")) {
          addressController.clear();
          return const SizedBox();
        }
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.star_border, color: ColorData.grayColor400),
              const SizedBox(
                width: 7,
              ),
              Expanded(child: Text(prediction.description ?? ""))
            ],
          ),
        );
      },
      seperatedBuilder: const Divider(),
      isCrossBtnShown: isCrossBtnShown,

    );
  }
}

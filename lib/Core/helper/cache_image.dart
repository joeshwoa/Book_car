

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/generated/assets.dart';
import 'loading_app_custom.dart';

class CacheImageCustom extends StatelessWidget {
  BoxFit ? boxFit;
  final String image;
   double? width;
   double? height;
  CacheImageCustom({Key? key, required this.image,  this.width,  this.height,this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      height: height,
      fit: boxFit??BoxFit.fill,
      placeholder: (context, url) => const LoadingAppCustom(),
      errorWidget: (context, url, error) {
        return Image.asset(Assets.userLogo,
            color: ColorData.primaryColor1000,
            width: width,height: height,fit: boxFit);
      },
    );
  }
}

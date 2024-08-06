import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/generated/assets.dart';

class UserAvatarCustom extends StatelessWidget {
  const UserAvatarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Unit(context).getHeightSize*0.14,
              width: Unit(context).getHeightSize*0.15,
              child: Stack(
                children: [
                  ClipOval(
                    child: cubit.fileImage!=null?
                      Image.file(cubit.fileImage!,
                        fit: BoxFit.fill,
                        height: Unit(context).getHeightSize*0.13,
                        width: Unit(context).getHeightSize*0.13,) :
                    CachedNetworkImage(imageUrl: cubit.userModel?.dataUserModel?.image??'', errorWidget: (context, url, error) => Image.asset(Assets.userProfileImageTest,fit: BoxFit.fill,
                      height: Unit(context).getHeightSize*0.13,
                      width: Unit(context).getHeightSize*0.13,),fit: BoxFit.cover,
                      height: Unit(context).getHeightSize*0.13,
                      width: Unit(context).getHeightSize*0.13,),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async{
                        XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery,maxWidth: 1080,maxHeight: 1080);
                        if(xFile != null){
                          cubit.selectFileImage(File(xFile.path));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(SizeData.s10),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorData.primaryColor25
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.userEditIcon,
                            height: 18,
                            width: 18,
                            color: ColorData.primaryColor500,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: SizeData.s20,),

            Text(
              cubit.userModel?.dataUserModel?.name??'',
              style: StyleData.textStyleGray600M14,
            ),
            SizedBox(height: SizeData.s5,),
            Container(
              width:80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorData.gradientColor1,
                    ColorData.gradientColor2,
                    ColorData.gradientColor3,
                    ColorData.gradientColor4,
                    ColorData.gradientColor5,
                    ColorData.gradientColor6,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';
import 'package:public_app/generated/assets.dart';

class UploadImageButtonCustom extends StatelessWidget {
  const UploadImageButtonCustom({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return InkWell(
            onTap: ()async{
              List<XFile> files = await ImagePicker().pickMultiImage(maxWidth: 1080,maxHeight: 1080) ;
              if(files.isNotEmpty){
                cubit.selectImages(files,);
              }
            },
            child: FDottedLine(
              color: ColorData.grayColor500,
              strokeWidth: 1,
              dottedLength: 10.0,
              space: 5.0,
              corner: FDottedLineCorner.all(SizeData.s6),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(SizeData.s14),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.kUploadImage.tr(),
                      style: StyleData.textStyleGray500M14.copyWith(
                          color: ColorData.grayColor500,
                          fontSize: Unit(context).getWidthSize*0.042
                      ),),
                    SizedBox(width: SizeData.s15,),
                    SvgPicture.asset(Assets.userAddImages),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class ShowImageSelectCustom extends StatelessWidget {
  const ShowImageSelectCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return cubit.listSelectImages.isNotEmpty?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...cubit.listSelectImages.map((e){
                      return Padding(
                        padding:EdgeInsets.symmetric(horizontal: SizeData.s4),
                        child: SizedBox(
                          height: Unit(context).getWidthSize*0.23,
                          width: Unit(context).getWidthSize*0.23,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(SizeData.s6),
                                child: Image.file(e,
                                height: Unit(context).getWidthSize*0.23,
                                width: Unit(context).getWidthSize*0.23,
                                fit: BoxFit.fill,),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: ()=>cubit.deleteOnlyImage(e),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.clear,color: ColorData.dangerColor1000,size: Unit(context).getWidthSize*0.05),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: SizeData.s15,),
            ],
          ):Container();
        });
  }
}


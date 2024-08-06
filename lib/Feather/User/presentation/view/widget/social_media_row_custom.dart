import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/helper/cache_image.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/services/launch_services.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';

class SocialMediaRowCustom extends StatelessWidget {
  const SocialMediaRowCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
      return (state is LoadingSocialModelState)?
      const LoadingAppCustom():
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
         ...cubit.listSocial.map((e){
           /*print(e.id! + " " + e.title! + " " + e.icon! + " " + e.link! );*/
           return iconSocial(
             context: context,
             fct: () async {
               await launchLink(Uri.parse(e.link??''));
             },
             assetImage: e.icon??'',
           );
         }),
          const Spacer(),
        ],
      );
    });
  }

  Widget iconSocial({required Function() fct,required String assetImage,required BuildContext context}){
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: SizeData.s4),
      child: InkWell(
        onTap: fct,
        child: ClipOval(
          child: CacheImageCustom(
            image: assetImage,
            height: Unit(context).getWidthSize*0.08,
            width: Unit(context).getWidthSize*0.08,
          ),
        ),
      ),
    );
  }

}

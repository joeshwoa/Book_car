import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/helper/loading_app_custom.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/app_bar_custom.dart';
import 'package:public_app/Core/widget/inputs_filed/input_text_custom.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_state.dart';

class FAQView extends StatefulWidget {

  const FAQView({super.key});

  @override
  State<FAQView> createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).faqData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorData.whiteColor200,
      body: BlocBuilder<UserCubit,UserState>(
        builder: (context,state){
          var cubit = UserCubit.get(context);
          return Stack(
            children: [
              AppBarCustom(title: LocaleKeys.kFAQ.tr()),
              Container(
                margin : EdgeInsets.only(top: Unit(context).getHeightSize*0.15,
                    left: SizeData.s15,
                    right: SizeData.s15),
                decoration: BoxDecoration(
                  color: ColorData.whiteColor200,
                  borderRadius: BorderRadius.circular(SizeData.s16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: EdgeInsets.all(SizeData.s16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputTextCustom(
                        controller: searchController,
                        hintText: LocaleKeys.kSearchByWord.tr(),
                        prefix: Icon(Icons.search,color: ColorData.grayColor200),
                        onChanged: (val){
                          cubit.searchFaq(search: searchController.text);
                        },
                      ),
                      SizedBox(height: SizeData.s20,),
                      Expanded(
                        child: (state is LoadingGetTermState)?
                        const LoadingAppCustom():
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.faqList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                    child: ExpansionTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(SizeData.s8),
                                        side: BorderSide(
                                          color: ColorData.grayColor300
                                        )
                                      ),
                                      collapsedShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(SizeData.s8),
                                          side: BorderSide(
                                              color: ColorData.grayColor300
                                          )
                                      ),

                                      childrenPadding: EdgeInsets.all(SizeData.s5),
                                      tilePadding: EdgeInsets.all(SizeData.s5),
                                      title: Text(cubit.faqList[index].question??'',
                                        style: StyleData.textStyleGray600R14),
                                      children: [
                                        Text(cubit.faqList[index].answer??'',
                                          style: StyleData.textStyleGray400R12,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

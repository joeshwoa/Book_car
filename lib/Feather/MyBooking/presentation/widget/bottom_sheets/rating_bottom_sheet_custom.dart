import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:public_app/Core/translations/locale_keys.g.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/size_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Core/unit/unit.dart';
import 'package:public_app/Core/widget/buttons/main_button_custom.dart';
import 'package:public_app/Core/widget/expansion_tile_custom.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/widget/dialogs/rating_submitted_dialog_custom.dart';
import 'package:public_app/generated/assets.dart';

class RatingBottomSheetCustom extends StatelessWidget {

  final String id;
  final String pickUpAddress;
  final String dropOffAddress;
  RatingBottomSheetCustom({super.key, required this.id, required this.pickUpAddress, required this.dropOffAddress});

  TextEditingController commentController = TextEditingController();

  late final MyBookingCubit cubit;

  bool first = true;

  @override
  Widget build(BuildContext context) {
    if (first) {
      first = false;
      cubit = context.read<MyBookingCubit>();

      commentController.text = cubit.tempComment;
    }
    return BlocListener<MyBookingCubit, MyBookingState>(
  listener: (context, state) {
    if (state is SuccessRatingState) {
      cubit.updateStateLessPageVar(change: () {
        cubit.ratingSanded = true;
      });
      context.pop();
      showDialog(context: context, builder: (context) => const RatingSubmittedDialogCustom());
    }
  },
  child: BlocBuilder<MyBookingCubit, MyBookingState>(
  builder: (context, state) {
    return Container(
      decoration: BoxDecoration(
        color: ColorData.whiteColor200,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeData.s16),
            topLeft: Radius.circular(SizeData.s16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        backgroundColor: ColorData.whiteColor200,
        body: Container(
          margin: EdgeInsets.all(SizeData.s12),
          decoration: BoxDecoration(
            color: ColorData.whiteColor200,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(SizeData.s16),
                topLeft: Radius.circular(SizeData.s16)),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(child: SizedBox()),
                      Text(
                        'Taxi - Booking Review',
                        style: StyleData.textStyleGray700M14,
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                size: SizeData.s24,
                                color: ColorData.grayColor600,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: SizeData.s6),
                        child: Text(
                          'Booking details',
                          style: StyleData.textStyleGray600M12,
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: ColorData.primaryColor50,
                            borderRadius: BorderRadius.circular(SizeData.s8),
                          ),
                          padding: EdgeInsets.all(SizeData.s12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: SizeData.s4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s68),
                                      child: Text(
                                        'Pick up',
                                        style: StyleData.textStyleGray600M12,
                                      ),
                                    ),
                                    Container(
                                      width: Unit(context).width(SizeData.s1),
                                      height: Unit(context).height(SizeData.s20),
                                      color: ColorData.primaryColor200,
                                    ),
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s200),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: SizeData.s8),
                                            child: SvgPicture.asset(
                                              Assets.myBookingLocationIcon,
                                              width: Unit(context).iconSize(SizeData.s20),
                                              height: Unit(context).iconSize(SizeData.s20),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Unit(context).width(SizeData.s172),
                                            child: Text(
                                              pickUpAddress,
                                              style: StyleData.textStyleGray700M12,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: SizeData.s4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s68),
                                      child: Text(
                                        'Drop off',
                                        style: StyleData.textStyleGray600M12,
                                      ),
                                    ),
                                    Container(
                                      width: Unit(context).width(SizeData.s1),
                                      height: Unit(context).height(SizeData.s20),
                                      color: ColorData.primaryColor200,
                                    ),
                                    SizedBox(
                                      width: Unit(context).width(SizeData.s200),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: SizeData.s8),
                                            child: SvgPicture.asset(
                                              Assets.myBookingLocationIcon,
                                              width: Unit(context).iconSize(SizeData.s20),
                                              height: Unit(context).iconSize(SizeData.s20),
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Unit(context).width(SizeData.s172),
                                            child: Text(
                                              dropOffAddress,
                                              style: StyleData.textStyleGray700M12,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Divider(
                  endIndent: Unit(context).width(SizeData.s20),
                  indent: Unit(context).width(SizeData.s20),
                  height: Unit(context).height(SizeData.s0_5),
                  color: ColorData.customColor6,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                  child: Text(
                      'How would you rate your experience?',
                    style: StyleData.textStyleGray600M12,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    child: RatingBar.builder(
                      initialRating: cubit.tempRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      wrapAlignment: WrapAlignment.spaceEvenly,
                      glow: false,
                      allowHalfRating: true,
                      maxRating: 5,
                      updateOnDrag: true,
                      ignoreGestures: false,
                      itemCount: 5,
                      unratedColor:
                      ColorData.grayColor200,
                      itemSize: Unit(context)
                          .iconSize(SizeData.s48),
                      itemBuilder: (context, _) =>
                          SvgPicture.asset(
                            Assets.myBookingStarIcon,
                            color: ColorData
                                .warningColor500,
                            width: Unit(context).iconSize(SizeData.s48),
                            height: Unit(context).iconSize(SizeData.s48),
                            fit: BoxFit.scaleDown,
                          ),
                      onRatingUpdate: (rate) {
                        cubit.updateStateLessPageVar(change: () {
                          cubit.tempRating = rate;
                        },);
                      },
                    ),
                  ),
                ),
                ExpansionTileCustom(
                    title: Text(
                      LocaleKeys.kAddComment.tr(),
                      style: StyleData.textStyleGray600R14,
                    ),
                    trailing: SvgPicture.asset(
                      Assets.userArrowRightIcon,
                      height: Unit(context).iconSize(SizeData.s22),
                      width: Unit(context).iconSize(SizeData.s22),
                      fit: BoxFit.scaleDown,
                      color: ColorData.grayColor600,
                    ),
                    trailingAngels: TrailingAngels.upAndDown,
                    initiallyExpanded: true,
                    padding: EdgeInsets.symmetric(vertical: SizeData.s8),
                    children: [
                      TextFormField(
                        controller: commentController,
                        decoration: InputDecoration(
                          border: BorderData.outlineInputBorderGray200W1R8,
                          enabledBorder: BorderData.outlineInputBorderGray200W1R8,
                          focusedBorder: BorderData.outlineInputBorderPrimary500W1R8,
                          errorBorder: BorderData.outlineInputBorderDanger400W1R8,
                          focusedErrorBorder: BorderData.outlineInputBorderDanger400W1R8,
                          hintText: LocaleKeys.kTypeHere.tr(),
                          hintStyle: StyleData.textStyleGray400R12,
                        ),
                        onChanged: (value) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempComment = value;
                          },);
                        },
                        autofocus: false,
                        autofillHints: const [],
                        textInputAction:
                        TextInputAction.done,
                        obscureText: false,
                        keyboardType:
                        TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                      )
                    ]
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: SizeData.s8),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        side: BorderSide(
                            color: ColorData.grayColor300),
                        activeColor:
                        ColorData.primaryColor1000,
                        onChanged: (value) {
                          cubit.updateStateLessPageVar(change: () {
                            cubit.tempAcceptedPrivacy = value?? false;
                          },);
                        },
                        value: cubit.tempAcceptedPrivacy,
                      ),
                      SizedBox(
                        width: Unit(context).getWidthSize*0.8,
                        child: Text(
                          'By clicking on the "Give your opinion" button below, you accept our general conditions and our privacy policy.',
                          style: StyleData.textStyleGray500R12,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeData.s12),
                  child: MainButtonCustom(
                    onTap: () {
                      cubit.updateStateLessPageVar(change: () {
                        cubit.ratingSanded = false;
                      });

                      cubit.rating(id: id);
                    },
                    text: 'Give you opinion',
                    textStyle: StyleData.textStylePrimary50SB16,
                    color: ColorData.primaryColor1000,
                    loading: !cubit.ratingSanded,
                    loadingColor: ColorData.primaryColor50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  },
),
);
  }
}

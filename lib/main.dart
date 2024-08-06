import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_app/Core/services/custom_bloc_observer.dart';
import 'package:public_app/Core/services/shared_pref_services.dart';
import 'package:public_app/Core/translations/codegen_loader.g.dart';
import 'package:public_app/Core/unit/app_routes.dart';
import 'package:public_app/Core/unit/border_data.dart';
import 'package:public_app/Core/unit/color_data.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Core/unit/style_data.dart';
import 'package:public_app/Feather/BookTaxi/presentation/manager/book_taxi_cubit.dart';
import 'package:public_app/Feather/MyBooking/presentation/manager/my_booking_cubit.dart';
import 'package:public_app/Feather/User/presentation/manager/user_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /*await EasyLocalization.ensureInitialized();*/ // make problem 'Locale data has not been initialized, call initializeDateFormatting(<locale>)'

  await dotenv.load(fileName: ".env");

  Bloc.observer = CustomBlocObserver();
  await SharedPreferencesServices.init();

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(EasyLocalization(
        path: 'lib/Core/translations/utils',
        supportedLocales: const [
          Locale('en'),
          Locale('fr'),
        ],
        fallbackLocale: Locale(ConstantData.kDefaultLung),
        startLocale: Locale(SharedPreferencesServices.getData(key: ConstantData.kLung)??ConstantData.kDefaultLung),
        assetLoader: const CodegenLoader(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider (create: (BuildContext context) => UserCubit(),),
            BlocProvider (create: (BuildContext context) => BookTaxiCubit(),),
            BlocProvider (create: (BuildContext context) => MyBookingCubit(),),
          ],
          child: const MyApp(),)));
  });


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    StyleData.init(context);
    BorderData.init(context);

    return MaterialApp.router(
      title: 'Public',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: ColorData.primaryColor1000),
      ),
      routerConfig: AppRouter.router,
    );
  }
}


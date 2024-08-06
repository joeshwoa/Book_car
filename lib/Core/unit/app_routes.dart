import 'package:go_router/go_router.dart';
import 'package:public_app/Core/unit/constant_data.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/add_additional_details_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/add_address_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/add_departure_date_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/find_driver_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/no_availability_out_side_countries_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/home/select_from_saved_places_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/booking_summary_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/offer_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/request_already_exist_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/request_sanded_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/request_cancelled_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/request_confirmation_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/request_filed_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/ticket_view.dart';
import 'package:public_app/Feather/BookTaxi/presentation/view/price_system/view_price_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/accept_offer_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/add_new_departure_date_for_rebook_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/booking_details_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/my_bookings_view.dart';
import 'package:public_app/Feather/MyBooking/presentation/view/rebook_view.dart';
import 'package:public_app/Feather/User/presentation/view/intro/on_boarding_view.dart';
import 'package:public_app/Feather/User/presentation/view/intro/splash_view.dart';
import 'package:public_app/Feather/User/presentation/view/layout_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/chat_with_us_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/contact_us_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/faq_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/help_center_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/help_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/privacy_policy_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/send_message_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/send_report_issue_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/help/terms_and_conditions_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/personal_data_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/place/add_saved_place_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/place/edit_saved_place_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/place/saved_places_view.dart';
import 'package:public_app/Feather/User/presentation/view/profile/profile_view.dart';

abstract class AppRouter {

  //User
  static const kSplashView='/';/*SplashView*/
  static const kOnBoardingView='/OnBoardingView';
  static const kProfileView='/ProfileView';
  static const kPersonalDataView='/PersonalDataView';
  static const kSavedPlacesView='/SavedPlacesView';
  static const kAddSavedPlacesView='/AddSavedPlacesView';
  static const kHelpView='/HelpView';
  static const kLayoutView='/LayoutView';
  static const kHelpCenterView='/HelpCenterView';
  static const kContactUsView='/ContactUsView';
  static const kSendMessageView='/SendMessageView';
  static const kSendReportIssueView='/SendReportIssueView';
  static const kFAQView='/FAQView';
  static const kPrivacyPolicyView='/PrivacyPolicyView';
  static const kTermsAndConditionsView='/TermsAndConditionsView';
  static const kEditSavedPlacesView='/EditSavedPlacesView';
  /*static const kAddNewPlaceView='/AddNewPlaceView';*/
  static const kChatWithUsView='/ChatWithUsView';

  // Book Taxi
  static const kFindDriverView='/FindDriverView';
  static const kAddAddressView='/AddAddressView';
  static const kSelectFromSavedPlacesView='/SelectFromSavedPlacesView';
  static const kAddDepartureDateView='/AddDepartureDateView';
  static const kAddAdditionalDetailsView='/AddAdditionalDetailsView';
  static const kViewPriceView='/ViewPriceView';
  static const kRequestSandedView='/RequestSandedView';
  static const kRequestConfirmationView='/RequestConfirmationView';
  static const kRequestFiledView='/RequestFiledView';
  static const kBookingSummaryView='/BookingSummaryView';
  static const kRequestCancelledView='/RequestCancelledView';
  static const kTicketView='/TicketView';
  static const kOfferView='/OfferView';
  static const kNoAvailabilityOutSideCountriesView='/NoAvailabilityOutSideCountriesView';
  static const kRequestAlreadyExistView='/RequestAlreadyExistView';

  // My Bookings
  static const kMyBookingsView='/MyBookingsView';
  static const kRebookView='/RebookView';
  static const kAddNewDepartureDateForRebookView='/AddNewDepartureDateForRebookView';
  static const kBookingDetailsView='/BookingDetailsView';
  static const kAcceptOfferView='/AcceptOfferView';

  static final GoRouter router = GoRouter(
    routes: [
      // User
      GoRoute(
          path: kSplashView,
          builder: (context, state)=> const SplashView()),
      GoRoute(
          path: kOnBoardingView,
          builder: (context, state)=> const OnBoardingView()),
      GoRoute(
          path: kLayoutView,
          builder: (context, state)=> LayoutView()),
      GoRoute(
          path: kProfileView,
          builder: (context, state) {
            return const ProfileView();
          }),
      GoRoute(
          path: kPersonalDataView,
          builder: (context, state)=> const PersonalDataView()),
      GoRoute(
          path: kSavedPlacesView,
          builder: (context, state)=> const SavedPlacesView()),
      GoRoute(
          path: kAddSavedPlacesView,
          builder: (context, state){
            Map<String , dynamic > ex = state.extra as Map<String , dynamic >;
            return AddSavedPlacesView(
              isEdit: ex['IsEdit'],
              address: ex['Address'],
              title: ex['Title'],
              id: ex['Id'],
            );
          }),
      GoRoute(
          path: kHelpView,
          builder: (context, state)=> const HelpView()),

      GoRoute(
          path: kHelpCenterView,
          builder: (context, state)=> const HelpCenterView()),
      GoRoute(
          path: kContactUsView,
          builder: (context, state)=> const ContactUsView()),
      GoRoute(
          path: kSendMessageView,
          builder: (context, state)=> const SendMessageView()),
      GoRoute(
          path: kSendReportIssueView,
          builder: (context, state)=> const SendReportIssueView()),
      GoRoute(
          path: kFAQView,
          builder: (context, state)=> const FAQView()),
      GoRoute(
          path: kPrivacyPolicyView,
          builder: (context, state)=> const PrivacyPolicyView()),
      GoRoute(
          path: kSplashView,
          builder: (context, state)=> const SplashView()),
      GoRoute(
          path: kOnBoardingView,
          builder: (context, state)=> const OnBoardingView()),
      GoRoute(
          path: kEditSavedPlacesView,
          builder: (context, state)=> const EditSavedPlacesView()),
      /*GoRoute(
          path: kAddNewPlaceView,
          builder: (context, state)=> const AddNewPlaceView()),*/
      GoRoute(
          path: kTermsAndConditionsView,
          builder: (context, state)=> const TermsAndConditionsView()),
      GoRoute(
          path: kChatWithUsView,
          builder: (context, state) => const ChatWithUsView()),

      // Book Taxi
      GoRoute(
          path: kFindDriverView,
          builder: (context, state) {
            final bool firstTrip = (state.extra as Map<String, dynamic>)['firstTrip'];
            return FindDriverView(firstTrip: firstTrip);
          }),
      GoRoute(
          path: kAddAddressView,
          builder: (context, state) {
            final AddressType addressType = (state.extra as Map<String, dynamic>)['addressType'];
            return AddAddressView(addressType: addressType,);
          }),
      GoRoute(
          path: kSelectFromSavedPlacesView,
          builder: (context, state) => const SelectFromSavedPlacesView()),
      GoRoute(
          path: kAddDepartureDateView,
          builder: (context, state) {
            final bool timeSection = (state.extra as Map<String, dynamic>)['timeSection'] ?? false;
            final bool firstTrip = (state.extra as Map<String, dynamic>)['firstTrip'];
            return AddDepartureDateView(timeSection: timeSection, firstTrip: firstTrip,);
          }),
      GoRoute(
          path: kAddAdditionalDetailsView,
          builder: (context, state) {
            final int tabNumber = (state.extra as Map<String, dynamic>)['tabNumber'] ?? 1;
            final bool firstTrip = (state.extra as Map<String, dynamic>)['firstTrip'];
            return AddAdditionalDetailsView(tabNumber: tabNumber, firstTrip: firstTrip,);
          }),
      GoRoute(
          path: kViewPriceView,
          builder: (context, state) {
            final bool secondPriceInRoundTrip = (state.extra as Map<String, dynamic>)['secondPriceInRoundTrip'];
            return ViewPriceView(secondPriceInRoundTrip: secondPriceInRoundTrip,);
          }),
      GoRoute(
          path: kRequestSandedView,
          builder: (context, state) {
            final bool showCancelButton = (state.extra as Map<String, dynamic>)['showCancelButton'];
            return RequestSandedView(showCancelButton: showCancelButton,);
          }),
      GoRoute(
          path: kRequestConfirmationView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return RequestConfirmationView(id: id,);
          }),
      GoRoute(
          path: kRequestFiledView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return RequestFiledView(id: id,);
          }),
      GoRoute(
          path: kBookingSummaryView,
          builder: (context, state) {
            return BookingSummaryView();
          }),
      GoRoute(
          path: kRequestCancelledView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return RequestCancelledView(id: id,);
          }),
      GoRoute(
          path: kTicketView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return TicketView(id: id,);
          }),
      GoRoute(
          path: kOfferView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return OfferView(id: id,);
          }),
      GoRoute(
          path: kNoAvailabilityOutSideCountriesView,
          builder: (context, state) => NoAvailabilityOutSideCountriesView()),
      GoRoute(
          path: kRequestAlreadyExistView,
          builder: (context, state) {
            final id = (state.extra as Map<String, dynamic>)['id'];
            return RequestAlreadyExistView(id: id,);
          }),

      // My Bookings
      GoRoute(
          path: kMyBookingsView,
          builder: (context, state) => MyBookingsView()),
      GoRoute(
          path: kRebookView,
          builder: (context, state) {
            final model = (state.extra as Map<String, dynamic>)['model'];
            return RebookView(model: model,);
          }),
      GoRoute(
          path: kAddNewDepartureDateForRebookView,
          builder: (context, state) {
            final bool timeSection = (state.extra as Map<String, dynamic>)['timeSection'] ?? false;
            return AddNewDepartureDateForRebookView(timeSection: timeSection,);
          }),
      GoRoute(
          path: kBookingDetailsView,
          builder: (context, state) {
            final model = (state.extra as Map<String, dynamic>)['model'];
            return BookingDetailsView(model: model,);
          }),
      GoRoute(
          path: kAcceptOfferView,
          builder: (context, state) {
            final model = (state.extra as Map<String, dynamic>)['model'];
            return AcceptOfferView(model: model,);
          }),
    ],
  );
}

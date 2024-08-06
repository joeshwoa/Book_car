part of 'my_booking_cubit.dart';

@immutable
sealed class MyBookingState {}

final class MyBookingInitial extends MyBookingState {}

class AnyState extends MyBookingState{}

class ChangeBookValue extends MyBookingState{}

class UpdateStateLessPage extends MyBookingState{}

class ChangeRebookValue extends MyBookingState{}

class LoadingMyBookingState extends MyBookingState{}
class SuccessMyBookingState extends MyBookingState{}
class FiledMyBookingState extends MyBookingState{}
class ErrorMyBookingsState extends MyBookingState{}

class LoadingCreateInvoiceState extends MyBookingState{}
class SuccessCreateInvoiceState extends MyBookingState{}
class FiledCreateInvoiceState extends MyBookingState{}
class ErrorCreateInvoiceState extends MyBookingState{}

class LoadingCardOnlinePaymentState extends MyBookingState{}
class SuccessCardOnlinePaymentState extends MyBookingState{}
class FiledCardOnlinePaymentState extends MyBookingState{}
class ErrorCardOnlinePaymentState extends MyBookingState{}

class LoadingRatingState extends MyBookingState{}
class SuccessRatingState extends MyBookingState{}
class FiledRatingState extends MyBookingState{}
class ErrorRatingState extends MyBookingState{}

class LoadingModificationRequestState extends MyBookingState{}
class SuccessModificationRequestState extends MyBookingState{}
class FiledModificationRequestState extends MyBookingState{}
class ErrorModificationRequestState extends MyBookingState{}

class SendingOfferAcceptState extends MyBookingState{}
class SuccessOfferAcceptState extends MyBookingState{}
class FiledOfferAcceptState extends MyBookingState{}
class ErrorOfferAcceptState extends MyBookingState{}
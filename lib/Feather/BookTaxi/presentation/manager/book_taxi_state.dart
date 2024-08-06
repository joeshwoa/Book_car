part of 'book_taxi_cubit.dart';

abstract class BookTaxiState{}

class BookTaxiInitialState extends BookTaxiState{}

class AnyState extends BookTaxiState{}

class UpdateStateLessPage extends BookTaxiState{}

class ChangeBookValue extends BookTaxiState{}
class ChangeRebookValue extends BookTaxiState{}

class LoadingBookPricesState extends BookTaxiState{}
class SuccessBookPricesState extends BookTaxiState{}
class FiledBookPricesState extends BookTaxiState{}
class ErrorBookPricesState extends BookTaxiState{}

class LoadingBookPricesRoundTripState extends BookTaxiState{}
class SuccessBookPricesRoundTripState extends BookTaxiState{}
class FiledBookPricesRoundTripState extends BookTaxiState{}
class ErrorBookPricesRoundTripState extends BookTaxiState{}

class LoadingBookTaxiState extends BookTaxiState{}
class SuccessBookTaxiState extends BookTaxiState{}
class FiledBookTaxiState extends BookTaxiState{}
class FiledPaymentBookTaxiState extends BookTaxiState{}
class ErrorBookTaxiState extends BookTaxiState{}

class LoadingSaveUnCompleteBookTaxiState extends BookTaxiState{}
class SuccessSaveUnCompleteBookTaxiState extends BookTaxiState{}
class FiledSaveUnCompleteBookTaxiState extends BookTaxiState{}
class ErrorSaveUnCompleteBookTaxiState extends BookTaxiState{}

class LoadingOfferState extends BookTaxiState{}
class SuccessOfferState extends BookTaxiState{}
class FiledOfferState extends BookTaxiState{}
class ErrorOfferState extends BookTaxiState{}

class LoadingOffersState extends BookTaxiState{}
class SuccessOffersState extends BookTaxiState{}
class FiledOffersState extends BookTaxiState{}
class ErrorOffersState extends BookTaxiState{}

class LoadingBookingDetailsState extends BookTaxiState{}
class SuccessBookingDetailsState extends BookTaxiState{}
class FiledBookingDetailsState extends BookTaxiState{}
class ErrorBookingDetailsState extends BookTaxiState{}

class SendingOfferAcceptState extends BookTaxiState{}
class SuccessOfferAcceptState extends BookTaxiState{}
class FiledOfferAcceptState extends BookTaxiState{}
class ErrorOfferAcceptState extends BookTaxiState{}

class SendingOfferRejectState extends BookTaxiState{}
class SuccessOfferRejectState extends BookTaxiState{}
class FiledOfferRejectState extends BookTaxiState{}
class ErrorOfferRejectState extends BookTaxiState{}

class LoadingTicketState extends BookTaxiState{}
class SuccessTicketState extends BookTaxiState{}
class FiledTicketState extends BookTaxiState{}
class ErrorTicketState extends BookTaxiState{}

class LoadingCancelRequestState extends BookTaxiState{}
class SuccessCancelRequestState extends BookTaxiState{}
class FiledCancelRequestState extends BookTaxiState{}
class ErrorCancelRequestState extends BookTaxiState{}

class LoadingCreateInvoiceState extends BookTaxiState{}
class SuccessCreateInvoiceState extends BookTaxiState{}
class FiledCreateInvoiceState extends BookTaxiState{}
class ErrorCreateInvoiceState extends BookTaxiState{}

class LoadingRebookState extends BookTaxiState{}
class SuccessRebookState extends BookTaxiState{}
class FiledRebookState extends BookTaxiState{}
class ErrorRebookState extends BookTaxiState{}

class SwitchToVanOptionalState extends BookTaxiState{}
class SwitchToVanMandatoryState extends BookTaxiState{}

class SwitchToVanOptionalForTempState extends BookTaxiState{}
class SwitchToVanMandatoryForTempState extends BookTaxiState{}

class SwitchToVanOptionalRoundTripState extends BookTaxiState{}
class SwitchToVanMandatoryRoundTripState extends BookTaxiState{}

class SwitchToVanOptionalForTempRoundTripState extends BookTaxiState{}
class SwitchToVanMandatoryForTempRoundTripState extends BookTaxiState{}

class AlreadyExistsBookErrorState extends BookTaxiState{
  final String id;
  AlreadyExistsBookErrorState({required this.id});
}
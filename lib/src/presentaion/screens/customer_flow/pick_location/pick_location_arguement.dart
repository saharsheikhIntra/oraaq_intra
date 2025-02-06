import 'package:oraaq/src/data/local/questionnaire/question_model.dart';

class PickLocationScreenArgument {
  final int categoryid;
  final List<QuestionModel> selectedServices;
  final String selectedDate;
  final int selectedOffer;
  final int standardAmount;
  final int userOfferAmount;

  PickLocationScreenArgument(
      this.categoryid,
      this.selectedServices,
      this.selectedDate,
      this.selectedOffer,
      this.userOfferAmount,
      this.standardAmount);
}

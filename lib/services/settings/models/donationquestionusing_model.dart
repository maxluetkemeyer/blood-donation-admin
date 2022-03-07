class DonationQuestionUsing{
  List<DonationQuestionUsingTrans> translations;
  bool isYesCorrect;

  DonationQuestionUsing({required this.translations,required this.isYesCorrect});
}

class DonationQuestionUsingTrans{
  String body;
  String lang;

  DonationQuestionUsingTrans({required this.body,required this.lang});
}
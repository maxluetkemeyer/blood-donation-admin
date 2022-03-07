import 'package:blooddonation_admin/services/settings/donation_service.dart';
import 'package:blooddonation_admin/services/settings/faq_service.dart';
import 'package:blooddonation_admin/services/settings/language_service.dart';

class SettingService {
  //Singleton
  static final SettingService _instance = SettingService._private();
  factory SettingService() => _instance;
  SettingService._private() {
    print("Starting Setting Service");
    LanguageService();
    FaqService();
    DonationService();
  }
}

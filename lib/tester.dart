import 'package:blooddonation_admin/misc/utils.dart';
import 'package:blooddonation_admin/models/appointment_model.dart';
import 'package:blooddonation_admin/models/capacity_model.dart';
import 'package:blooddonation_admin/models/person_model.dart';
import 'package:blooddonation_admin/services/calendar_service.dart';
import 'package:blooddonation_admin/models/request_model.dart';
import 'package:blooddonation_admin/services/capacity_service.dart';
import 'package:blooddonation_admin/services/settings/models/donation_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/faq_question_model.dart';
import 'package:blooddonation_admin/services/settings/models/language_model.dart';
import 'package:blooddonation_admin/services/settings/settings_service.dart';

void addTestAppointments() {
  CalendarService cs = CalendarService();

  Appointment a1 = Appointment(
    id: 0,
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Hans",
    ),
  );
  Appointment a2 = Appointment(
    id: 1,
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      name: "Alina",
    ),
  );
  Appointment a3 = Appointment(
    id: 2,
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
  );
  Appointment a4 = Appointment(
    id: 3,
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
  );
  a4.start = a4.start.add(const Duration(hours: -2));
  Appointment a5 = Appointment(
    id: 4,
    start: extractDay(DateTime.now()).add(
      const Duration(
        days: 10,
        hours: 12,
      ),
    ),
    duration: const Duration(hours: 1),
  );

  Appointment a6 = Appointment(
    id: 5,
    start: extractDay(DateTime.now()).add(const Duration(hours: 9)),
    duration: const Duration(minutes: 15),
    person: Person(
      birthday: DateTime.now(),
      name: "Bob",
      gender: "male",
    ),
  );

  Appointment a7 = Appointment(
    id: 6,
    start: extractDay(DateTime.now()).add(const Duration(hours: 10)),
    duration: const Duration(minutes: 30),
    person: Person(
      birthday: DateTime.now(),
      name: "Alice",
      gender: "female",
    ),
  );

  Appointment a8 = Appointment(
    id: 7,
    start: extractDay(DateTime.now()).add(const Duration(hours: 20)),
    duration: const Duration(minutes: 30),
    person: Person(
      birthday: DateTime(1987, 3, 22),
      name: "John",
      gender: "male",
    ),
  );

  cs.addAppointment(a1);
  cs.addAppointment(a2);
  cs.addAppointment(a3);
  cs.addAppointment(a4);
  cs.addAppointment(a5);
  cs.addAppointment(a6);
  cs.addAppointment(a7);
  cs.addAppointment(a8);
}

void addTestRequests() {
  CalendarService cs = CalendarService();

  Appointment a1 = Appointment(
    id: 99,
    start: extractDay(DateTime.now()).add(const Duration(hours: 10)),
    duration: const Duration(minutes: 15),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Lukas",
    ),
    request: Request(
      created: DateTime.now(),
      status: 'pending',
    ),
  );

  Appointment a2 = Appointment(
    id: 98,
    start: extractDay(DateTime.now()).add(Duration(hours: 24 + DateTime.now().hour + 2)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "male",
      name: "Jonas",
    ),
    request: Request(
      created: DateTime.now().add(const Duration(hours: -24)),
      status: 'pending',
    ),
  );

  Appointment a3 = Appointment(
    id: 97,
    start: extractDay(DateTime.now()).add(Duration(hours: DateTime.now().hour)),
    duration: const Duration(hours: 1),
    request: Request(
      created: DateTime.now(),
      status: 'pending',
    ),
    person: Person(
      birthday: DateTime(1985, 05, 16),
      gender: "female",
      name: "Anne",
    ),
  );

  Appointment a4 = Appointment(
    id: 96,
    start: extractDay(DateTime.now()).add(Duration(hours: 48 + DateTime.now().hour - 2)),
    duration: const Duration(hours: 1),
    person: Person(
      birthday: DateTime.now(),
      gender: "female",
      name: "Julia",
    ),
    request: Request(
      created: DateTime.now().add(const Duration(hours: -24)),
      status: 'pending',
    ),
  );

  cs.addAppointment(a1);
  cs.addAppointment(a2);
  cs.addAppointment(a3);
  cs.addAppointment(a4);
}

void addTestPlannerEvents() {
  CapacityService ss = CapacityService();

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 06, 08), duration: const Duration(hours: 4), slots: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 09, 09), duration: const Duration(hours: 6), slots: 10),
  );

  ss.addCapacity(
    Capacity(start: DateTime(2021, 12, 10, 08), duration: const Duration(hours: 4), slots: 10),
  );

  ss.addCapacity(
    Capacity(
      start: extractDay(DateTime.now()).add(const Duration(hours: 8)),
      duration: const Duration(hours: 14),
      slots: 4,
    ),
  );
}

void addTestSettings() {
  SettingService ss = SettingService();

  //Languages
  ss.addLanguage(Language(
    abbr: "de",
    name: "Deutsch",
  ));
  ss.addLanguage(Language(
    abbr: "en",
    name: "English",
  ));

  //FAQ
  ss.addFaqQuestion(FaqQuestion(
    translations: [
      FaqQuestionTranslation(
        head: "Wie kann ich in dieser App einen Termin zum Blutspenden buchen?",
        body:
            "Wenn Sie unten auf dem Startbildschirm die Option „Termine“ auswählen, werden Sie durch den Buchungsvorgang für einen Blutspendetermin geführt.",
        lang: ss.getLanguages()[0],
      ),
      FaqQuestionTranslation(
        head: "How can I book an appointment to donate blood in this app?",
        body:
            "When you select the 'Appointments' option at the bottom of the home screen, you will be guided through the process of booking a blood donation appointment.",
        lang: ss.getLanguages()[1],
      ),
    ],
  ));

  ss.addFaqQuestion(FaqQuestion(
    translations: [
      FaqQuestionTranslation(
        head: "Warum sollte ich Blut spenden?",
        body:
            "Blut kann durch keine andere Flüssigkeit und keinen anderen Stoff ersetzt werden. Folglich sind Blutspenden essentiell für die Krankenversorgung. Eine einzige Blutspende von Ihnen könnte bis zu drei Leben retten.",
        lang: ss.getLanguages()[0],
      ),
      FaqQuestionTranslation(
        head: "Why should I donate blood?",
        body:
            "Blood cannot be replaced by any other fluid or substance. As a result, blood donations are essential for patient care. A single blood donation from you could save up to three lives.",
        lang: ss.getLanguages()[1],
      ),
    ],
  ));

  ss.addFaqQuestion(FaqQuestion(
    translations: [
      FaqQuestionTranslation(
        head: "Was muss ich als Erstspender:in beachten?",
        body:
            "Bei Ihrer ersten Blutspende dauert der Aufenthalt etwas länger, da wir einige Formalitäten zu erledigen haben und mit Ihnen ein ausführliches Informationsgespräch führen möchten. Am Empfang werden Ihre Personalien unter Vorlage des Personalausweises oder Reisepasses aufgenommen. Die Daten unterliegen selbstverständlich dem Datenschutz. Anschließend erhalten Erstspender:innen einen umfangreichen Fragebogen, damit wir Ihre Krankengeschichte und eventuelle Ausschlusskriterien für eine Spende erfassen können. Damit Sie mit einen sicheren Gefühl zu Ihrer ersten Blutspende gehen können, legen wir besonderen Wert darauf, dass ein Erstspender umfassend informiert wird.",
        lang: ss.getLanguages()[0],
      ),
      FaqQuestionTranslation(
        head: "What do I have to consider as a first-time donor?",
        body:
            "For your first blood donation, your stay will take a little longer, as we have some formalities to complete and would like to have a detailed information talk with you. At the reception, your personal data will be taken upon presentation of your identity card or passport. The data is of course subject to data protection. Afterwards, first-time donors will receive a comprehensive questionnaire so that we can record your medical history and any exclusion criteria for a donation. So that you can go to your first blood donation with a safe feeling, we attach particular importance to the fact that a first-time donor is comprehensively informed.",
        lang: ss.getLanguages()[1],
      ),
    ],
  ));

  ss.addFaqQuestion(FaqQuestion(
    translations: [
      FaqQuestionTranslation(
        head: "Was muss ich vor einer Blutspende beachten?",
        body:
            "Am Tag Ihrer Blutspende sollten Sie viel trinken und normal essen, um Ihren Körper auf die Blutspende vorzubereiten. Auch sollten Sie einen Tag vor der Blutspende keine allzu fetthaltigen Speisen zu sich nehmen, da dies Einfluss auf die Qualität Ihres Blutplasmas haben kann. Das Rauchen einer Zigarette vor der Blutspende kann ebenfalls die Qualität Ihrer Blutkonserve beeinflussen. Vor und nach der Blutspende sollten Sie auf sportliche Aktivitäten verzichten.",
        lang: ss.getLanguages()[0],
      ),
      FaqQuestionTranslation(
        head: "What do I need to consider before donating blood?",
        body:
            "On the day of your blood donation, you should drink plenty of fluids and eat normally to prepare your body for blood donation. Also, you should not eat foods that are too fatty the day before you donate blood, as this can affect the quality of your blood plasma. Smoking a cigarette before donating blood can also affect the quality of your blood plasma. You should refrain from sports activities before and after donating blood.",
        lang: ss.getLanguages()[1],
      ),
    ],
  ));

  //Donation Questions
  ss.addDonationQuestion(
    DonationQuestion(
      translations: [
        DonationQuestionTranslation(
          body: "Sind Sie positiv auf HIV getestet worden oder haben Sie die Befürchtung evtl. HIV-positiv zu sein?",
          lang: ss.getLanguages()[0],
        ),
        DonationQuestionTranslation(
          body: "Have you tested positive for HIV or are you concerned that you may be HIV positive?",
          lang: ss.getLanguages()[1],
        ),
      ],
      isYesCorrect: false,
    ),
  );

  ss.addDonationQuestion(
    DonationQuestion(
      translations: [
        DonationQuestionTranslation(
          body: "Wurden bei Ihnen oder einem Ihrer Blutsverwandten 1. Grades die Creutzfeldt-Jakob-Krankheit erkannt?",
          lang: ss.getLanguages()[0],
        ),
        DonationQuestionTranslation(
          body: "Have you or any of your 1st-degree blood relatives been diagnosed with Creutzfeldt-Jakob disease?",
          lang: ss.getLanguages()[1],
        ),
      ],
      isYesCorrect: false,
    ),
  );
}

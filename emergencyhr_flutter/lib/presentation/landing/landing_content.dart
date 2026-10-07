import 'package:flutter/material.dart';

import '../../core/cores.dart';

/// Copy and placeholders for the web landing page, word for word from
/// `landing-intro/screens/Main.dc.html`.
abstract final class LandingContent {
  // Placeholders to fill in before launch. Anything in square brackets is
  // shown as written and is not a link until it is replaced.
  static const appStoreLink = 'App Store';
  static const googlePlayLink = 'Google Play';
  static const contactEmail = 'gloryolaifa@gmail.com';

  /// No Privacy or Terms pages exist yet; set these to make them links.
  static const String? privacyUrl = null;
  static const String? termsUrl = null;

  static bool isPlaceholder(String value) => value.startsWith('[');

  static const appName = 'EmergencyHr';
  static const navLinks = [
    ('How it works', LandingSection.how),
    ('For hospitals', LandingSection.hospitals),
    ('Pilot areas', LandingSection.areas),
    ('FAQ', LandingSection.faq),
  ];

  // Hero
  static const pilotBadge = 'Now in pilot across Lagos';
  static const heroTitle = 'When every minute matters, know where to go.';
  static const heroBody =
      'EmergencyHr shows hospitals near you that can take the patient right '
      'now: free beds, a doctor on duty, and how recently the hospital itself '
      'confirmed it.';
  static const heroEmergency = 'Emergency: find a hospital now';
  static const heroNote =
      'No account needed. Works in your browser and uses your location.';

  // Problem and answer
  static const problemCap = 'The problem';
  static const problemTitle =
      'Finding a hospital is easy. Finding one that can take the patient is '
      'not.';
  static const problemBody =
      'In an emergency, families often drive from hospital to hospital, only '
      'to hear there is no bed, no doctor, or no unit for this kind of case. '
      'Every one of those trips costs time the patient does not have.';
  static const answerCap = 'Our answer';
  static const answerTitle =
      'Hospitals tell us who they can take. We show you, live.';
  static const answerBody =
      'Emergency desks update their status from a phone in seconds. You see '
      'it ranked by who can treat the patient and how close they are, so you '
      'can call ahead and go to the right place first.';

  // How it works
  static const howCap = 'How it works';
  static const howTitle = 'Three steps, no questions first';
  static const steps = [
    (
      'Tap Emergency',
      'We find your location and list nearby hospitals straight away. '
          'Telling us what happened is optional.',
    ),
    (
      'See who can take you',
      'Hospitals that are accepting, with free beds and a doctor on duty, '
          'come first. Every status shows how fresh it is.',
    ),
    (
      'Call, go, and alert family',
      'Call the emergency desk or get directions in one tap. We can text '
          'your family where you are going.',
    ),
  ];

  // Status explainer
  static const trustCap = 'Information you can trust';
  static const trustTitle = 'Every status says how old it is';
  static const trustBody =
      'Only verified hospital staff can change a status. If it has not been '
      'confirmed recently, we say so plainly and tell you to call first.';
  static const statuses = [
    ('Accepting emergencies. Confirmed 4 min ago.', StatusTone.positive),
    ('Last confirmed 45 min ago. Call ahead.', StatusTone.warning),
    ('Unverified. Call before going.', StatusTone.unverified),
    ('Not accepting new emergencies', StatusTone.neutral),
  ];

  // Features
  static const featuresCap = 'What you get';
  static const featuresTitle = 'Everything you need on the way';
  static const features = [
    (
      Icons.monitor_heart_outlined,
      'Live hospital status',
      'Accepting or paused, emergency and ICU beds, doctor on duty, and '
          'whether a deposit is required.',
    ),
    (
      Icons.verified_outlined,
      'Verified hospitals only',
      'Every hospital is visited and checked by our team before its status '
          'is shown as confirmed.',
    ),
    (
      Icons.medical_services_outlined,
      'First aid while you wait',
      'Short, numbered steps for bleeding, burns, chest pain and more. Works '
          'without signal.',
    ),
    (
      Icons.chat_bubble_outline,
      'Health Assistant',
      'Ask a general health question. If it sounds like an emergency, it '
          'sends you straight to care.',
    ),
    (
      Icons.sms_outlined,
      'Family alerts',
      'Text up to three people the hospital you are heading to and your '
          'location, by SMS or WhatsApp.',
    ),
    (
      Icons.signal_cellular_alt_rounded,
      'Made for weak signal',
      'Your last results and first aid are saved on the phone, so you are '
          'never left with a blank screen.',
    ),
  ];

  // For hospitals
  static const hospitalsCap = 'For hospitals';
  static const hospitalsTitle =
      'Tell patients you can take them, in 30 seconds';
  static const hospitalsBody =
      'Your emergency desk updates beds, doctor on duty and accepting status '
      'from any phone or computer. Patients arrive at the right time, to the '
      'right unit.';
  static const hospitalPoints = [
    'Free to join during the pilot',
    'Our field team sets you up and trains your desk staff on site',
    'Quick updates by app, web or WhatsApp',
    'An audit log of every change, by who and when',
  ];

  // Pilot areas
  static const areasCap = 'Pilot areas';
  static const areasTitle = 'Live across Lagos and Ogbomoso';
  static const areasBody =
      'Outside these areas you can still use the app. We show every listed '
      'hospital and tell you to call first.';

  // FAQ
  static const faqCap = 'FAQ';
  static const faqTitle = 'Questions';
  static const faqs = [
    (
      'Do I need an account in an emergency?',
      'No. Emergency, hospital listings, calling and directions all work '
          'without an account. Sign in only to alert family or use the Health '
          'Assistant.',
    ),
    (
      'How do you know a hospital can take the patient?',
      'The hospital emergency desk updates its own status. We show exactly '
          'how long ago it was confirmed, and we ask you to call ahead when it '
          'is not recent.',
    ),
    (
      'Is EmergencyHr a medical service?',
      'No. EmergencyHr is an information and navigation service, not a '
          'medical provider. If in doubt, call 112.',
    ),
    ('What does it cost?', 'Using EmergencyHr is free.'),
    (
      'What happens to my health details?',
      'Medical details are optional, stored encrypted only with your '
          'consent, and never shared with hospitals or family automatically. '
          'You can export or delete your data at any time.',
    ),
  ];

  // App call to action
  static const appTitle = 'Save it before you need it';
  static const appBody =
      'Get the app on your phone, add your emergency contacts, and you are '
      'ready.';

  // Footer
  static const disclaimer =
      'EmergencyHr is an information and navigation service, not a medical '
      'provider. If in doubt, call 112.';
  static const copyright = '© 2026 EmergencyHr';

  /// Required by the open-data licence (CC BY 4.0) of the imported
  /// hospital locations.
  static const dataCredit =
      'Hospital locations include data from GRID3 (CC BY 4.0).';
}

/// Page anchors: `#how`, `#hospitals`, `#areas`, `#faq`, `#app`.
enum LandingSection {
  how,
  hospitals,
  areas,
  faq,
  app;

  static LandingSection? fromFragment(String fragment) =>
      values.where((s) => s.name == fragment).firstOrNull;
}

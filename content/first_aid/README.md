# First-aid cards

One JSON file per emergency type. Each card has at most 6 "Do" steps and a
"Don't" section.

All cards are **draft content**. `reviewedBy` and `reviewedAt` stay empty until
a clinician signs off. Debug builds show "Draft content" on unreviewed cards.

The Flutter app keeps a bundled copy in `emergencyhr_flutter/assets/first_aid/`
for first-launch offline use. A test fails if the two copies differ, so after
editing a card here, copy it there too.

The server reads these files for the app and for the Health Assistant.

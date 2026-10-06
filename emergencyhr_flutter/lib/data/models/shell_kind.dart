import 'package:emergencyhr_client/emergencyhr_client.dart';

/// The app's sections. Which ones a user can open depends on their roles.
enum ShellKind {
  public(label: 'Public'),
  desk(label: 'Hospital desk'),
  agent(label: 'Field agent'),
  admin(label: 'Admin');

  const ShellKind({required this.label});

  final String label;

  /// Roles that grant access to this shell. Public is open to everyone.
  Set<UserRole> get roles => switch (this) {
    ShellKind.public => const {},
    ShellKind.desk => const {UserRole.hospitalAdmin, UserRole.deskStaff},
    ShellKind.agent => const {UserRole.fieldAgent},
    ShellKind.admin => const {UserRole.platformAdmin},
  };
}

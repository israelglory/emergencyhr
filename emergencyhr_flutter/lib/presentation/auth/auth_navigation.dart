import '../../core/cores.dart';

/// Where to go after signing in or creating an account.
Future<void> openAfterSignIn({
  required SessionService session,
  required NavigationService navigation,
  String? next,
}) async {
  await session.refresh();
  await navigation.clearStackAndShow<void>(
    next ?? AppRoutes.forShell(session.preferredShell),
  );
}

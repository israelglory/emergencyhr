import '../../../generated/protocol.dart';

/// Allowed manual onboarding stage changes. `verified` is reached only by a
/// platform admin approving verification, and `live` only automatically when
/// the go-live checklist is complete.
abstract final class StageRules {
  static const _preVerified = [
    OnboardingStage.seeded,
    OnboardingStage.contacted,
    OnboardingStage.visited,
    OnboardingStage.staffTrained,
  ];

  /// Returns null when allowed, or the reason it is not.
  static String? checkManualMove({
    required OnboardingStage from,
    required OnboardingStage to,
    required bool isPlatformAdmin,
    required bool trainingCompleted,
  }) {
    if (from == to) return 'The facility is already at this stage.';
    if (to == OnboardingStage.live) {
      return 'Facilities go live automatically when the checklist is done.';
    }
    if (to == OnboardingStage.verified) {
      return 'Only a platform admin can verify, by approving the submission.';
    }
    if (to == OnboardingStage.paused || to == OnboardingStage.declined) {
      return null;
    }
    if (to == OnboardingStage.staffTrained && !trainingCompleted) {
      return 'Complete training mode first.';
    }
    if (from == OnboardingStage.paused || from == OnboardingStage.declined) {
      return null;
    }
    final fromIndex = _preVerified.indexOf(from);
    final toIndex = _preVerified.indexOf(to);
    if (fromIndex == -1) {
      // From verified or live, only a platform admin can move back.
      return isPlatformAdmin ? null : 'Only a platform admin can do this.';
    }
    if (toIndex < fromIndex && !isPlatformAdmin) {
      return 'Only a platform admin can move a facility back.';
    }
    return null;
  }

  static bool isAtLeast(OnboardingStage stage, OnboardingStage target) {
    const order = [
      OnboardingStage.seeded,
      OnboardingStage.contacted,
      OnboardingStage.visited,
      OnboardingStage.staffTrained,
      OnboardingStage.verified,
      OnboardingStage.live,
    ];
    final a = order.indexOf(stage);
    final b = order.indexOf(target);
    return a != -1 && b != -1 && a >= b;
  }
}

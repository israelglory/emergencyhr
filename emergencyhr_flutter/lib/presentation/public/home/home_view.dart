import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: HomeViewModel.new,
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        final p = context.palette;
        return AppPage(
          appBar: _HomeBar(
            trailing: model.isSignedIn
                ? _Avatar(initials: model.initials, onTap: model.openAccount)
                : AppButton(
                    title: 'Sign in',
                    variant: AppButtonVariant.tonal,
                    size: AppButtonSize.small,
                    expand: false,
                    onPressed: model.signIn,
                  ),
          ),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screen,
            AppSpacing.small,
            AppSpacing.screen,
            AppSpacing.screen,
          ),
          body: SectionColumn(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      model.greeting,
                      style: AppTypography.greeting.copyWith(
                        color: p.text,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                  if (model.locationLabel != null) ...[
                    const SizedBox(height: AppSpacing.half),
                    Row(
                      children: [
                        Icon(
                          Icons.place_outlined,
                          size: 16,
                          color: p.textSecondary,
                        ),
                        const SizedBox(width: AppSpacing.half),
                        AppText.caption(model.locationLabel!),
                      ],
                    ),
                  ],
                ],
              ),
              EmergencyButton(onPressed: model.startEmergency),
              AppButton.secondary(
                title: 'Call 112',
                icon: Icons.call_outlined,
                onPressed: model.call112,
              ),
              if (model.showWork)
                _Group(
                  title: 'Your work',
                  child: AppListCard(
                    children: [
                      for (final item in model.work)
                        AppListRow(
                          leading: IconTile(item.icon),
                          title: item.title,
                          subtitle: item.subtitle,
                          onTap: item.onTap,
                        ),
                    ],
                  ),
                ),
              _Group(
                title: 'Quick help',
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var i = 0; i < model.quickHelp.length; i++) ...[
                        if (i > 0) const SizedBox(width: AppSpacing.tight),
                        Expanded(
                          child: _QuickHelpCard(item: model.quickHelp[i]),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HomeViewModel.disclaimer,
                    style: AppTypography.micro.copyWith(
                      height: 17 / 12,
                      color: p.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tight),
                  Semantics(
                    link: true,
                    child: InkWell(
                      onTap: model.joinAsHospital,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.half,
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: HomeViewModel.joinPrompt,
                            children: [
                              TextSpan(
                                text: HomeViewModel.joinLink,
                                style: TextStyle(
                                  color: p.primaryText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          style: AppTypography.micro.copyWith(
                            color: p.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Logo bar: red rounded square with a white plus, then the app name.
class _HomeBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeBar({required this.trailing});

  final Widget trailing;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.background,
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.contentMaxWidth,
            ),
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 16, 0),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: p.emergency,
                        borderRadius: BorderRadius.circular(AppRadius.status),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.x1),
                    Expanded(
                      child: Text(
                        HomeViewModel.appName,
                        style: AppTypography.title.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          color: p.text,
                        ),
                      ),
                    ),
                    trailing,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials, required this.onTap});

  final String initials;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Semantics(
      button: true,
      label: 'Account',
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: AppSizes.tapTarget,
        child: Center(
          child: Material(
            color: p.primaryContainer,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onTap,
              customBorder: const CircleBorder(),
              child: SizedBox.square(
                dimension: 40,
                child: Center(
                  child: Text(
                    initials,
                    style: AppTypography.label.copyWith(
                      fontWeight: FontWeight.w700,
                      color: p.primaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Caption caps above a group, 10 apart.
class _Group extends StatelessWidget {
  const _Group({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: AppText.caps(title)),
        const SizedBox(height: AppSpacing.tight),
        child,
      ],
    );
  }
}

class _QuickHelpCard extends StatelessWidget {
  const _QuickHelpCard({required this.item});

  final HomeShortcut item;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      onTap: item.onTap,
      padding: const EdgeInsets.all(14),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 128 - 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTile(item.icon),
            const SizedBox(height: AppSpacing.tight),
            Text(
              item.title,
              style: AppTypography.label.copyWith(
                height: 18 / 14,
                color: p.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.subtitle,
              style: AppTypography.micro.copyWith(color: p.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

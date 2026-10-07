import 'package:emergencyhr_client/emergencyhr_client.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import 'invite_sheet_viewmodel.dart';

class InviteSheetView extends StatelessWidget {
  const InviteSheetView({
    super.key,
    required this.facilityId,
    required this.role,
    this.onCreated,
  });

  final int facilityId;
  final UserRole role;
  final VoidCallback? onCreated;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InviteSheetViewModel>.reactive(
      viewModelBuilder: () => InviteSheetViewModel(
        facilityId: facilityId,
        role: role,
        onCreated: onCreated,
      ),
      builder: (context, model, _) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.x3,
          0,
          AppSpacing.x3,
          AppSpacing.x3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText.title(model.title),
            const SizedBox(height: AppSpacing.x1),
            if (!model.isCreated) ...[
              const AppText(
                InviteSheetViewModel.explainer,
                tone: AppTextTone.secondary,
              ),
              const SizedBox(height: AppSpacing.x2),
              AppTextField(
                label: 'Their email (optional)',
                hintText: 'name@example.com',
                controller: model.emailController,
                keyboardType: TextInputType.emailAddress,
                errorText: model.emailError,
                onChanged: model.onEmailChanged,
              ),
              const SizedBox(height: AppSpacing.x3),
              AppButton(
                title: 'Create invite',
                loading: model.isBusy,
                onPressed: model.create,
              ),
            ] else ...[
              AppText(model.sentLabel, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x2),
              Center(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(AppSpacing.x2),
                  child: QrImageView(
                    data: model.qrData,
                    size: 220,
                    semanticsLabel: 'Invite QR code',
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.x2),
              const AppText.caption('Invite code', alignment: TextAlign.center),
              AppText.display(
                model.shortCode,
                numeric: true,
                alignment: TextAlign.center,
              ),
              AppText.caption(model.expiresLabel, alignment: TextAlign.center),
              const SizedBox(height: AppSpacing.x3),
              AppButton.secondary(
                title: 'Copy invite link',
                icon: Icons.copy_outlined,
                onPressed: model.copyLink,
              ),
              const SizedBox(height: AppSpacing.x1),
              AppButton(title: 'Done', onPressed: model.close),
            ],
          ],
        ),
      ),
    );
  }
}

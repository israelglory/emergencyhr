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
      builder: (context, model, _) => AppSheet(
        title: model.title,
        children: model.isCreated
            ? [
                Center(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(AppSpacing.x1),
                    child: QrImageView(
                      data: model.qrData,
                      size: 200,
                      semanticsLabel: 'Invite QR code',
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText.micro('Invite code'),
                          SelectableText(
                            model.shortCode,
                            style: AppTypography.title.copyWith(
                              fontSize: 24,
                              height: 30 / 24,
                              letterSpacing: 2,
                              color: context.palette.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppText.caption(model.expiresLabel),
                  ],
                ),
                AppText.caption(model.sentLabel),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        title: 'Copy invite link',
                        size: AppButtonSize.medium,
                        onPressed: model.copyLink,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tight),
                    Expanded(
                      child: AppButton(
                        title: 'Done',
                        size: AppButtonSize.medium,
                        onPressed: model.close,
                      ),
                    ),
                  ],
                ),
              ]
            : [
                const AppText.caption(InviteSheetViewModel.explainer),
                AppTextField(
                  label: 'Their email (optional)',
                  hintText: 'name@example.com',
                  controller: model.emailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: model.emailError,
                  onChanged: model.onEmailChanged,
                ),
                AppButton(
                  title: 'Create invite',
                  loading: model.isBusy,
                  onPressed: model.create,
                ),
              ],
      ),
    );
  }
}

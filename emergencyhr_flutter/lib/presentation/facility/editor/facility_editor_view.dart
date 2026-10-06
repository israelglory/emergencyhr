import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/cores.dart';
import '../../../data/models/route_args.dart';
import 'facility_editor_viewmodel.dart';

class FacilityEditorView extends StatelessWidget {
  const FacilityEditorView({super.key, required this.args});

  final FacilityEditorArgs args;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FacilityEditorViewModel>.reactive(
      viewModelBuilder: () => FacilityEditorViewModel(args: args),
      onViewModelReady: (model) => model.onReady(),
      builder: (context, model, _) {
        if (model.isLoading) {
          return AppPage(
            title: model.title,
            scrollable: false,
            body: const LoadingState(),
          );
        }
        if (model.hasError) {
          return AppPage(
            title: model.title,
            scrollable: false,
            body: ErrorState(
              message: model.errorMessage!,
              onRetry: model.onReady,
            ),
          );
        }
        const gap = SizedBox(height: AppSpacing.x2);
        return AppPage(
          title: model.title,
          bottom: AppButton(
            title: model.saveLabel,
            large: true,
            loading: model.isSaving,
            onPressed: model.save,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (model.savedOffline) ...[
                const NoticeBanner(
                  message: FacilityEditorViewModel.offlineNotice,
                  tone: StatusTone.warning,
                  icon: Icons.cloud_off_outlined,
                ),
                gap,
              ],
              AppTextField(
                label: 'Hospital name',
                controller: model.nameController,
                textCapitalization: TextCapitalization.words,
                errorText: model.errorFor('name'),
                onChanged: model.onFieldChanged,
              ),
              gap,
              const AppText.label('Type'),
              const SizedBox(height: AppSpacing.x1),
              ChipGroup(items: model.typeOptions, onSelected: model.setType),
              gap,
              AppTextField(
                label: 'Address',
                controller: model.addressController,
                textCapitalization: TextCapitalization.words,
                errorText: model.errorFor('address'),
                onChanged: model.onFieldChanged,
                maxLines: 2,
              ),
              gap,
              const AppText.label('Area'),
              const SizedBox(height: AppSpacing.x1),
              DropdownMenu<String>(
                initialSelection: model.area,
                expandedInsets: EdgeInsets.zero,
                onSelected: model.setArea,
                dropdownMenuEntries: [
                  for (final a in model.areaOptions)
                    DropdownMenuEntry(value: a, label: a),
                ],
              ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Map pin'),
              AppText(model.pinLabel, tone: AppTextTone.secondary),
              const SizedBox(height: AppSpacing.x1),
              AppButton.secondary(
                title: 'Use my current location',
                icon: Icons.my_location_outlined,
                loading: model.isLocating,
                onPressed: model.useMyLocation,
              ),
              const SizedBox(height: AppSpacing.x1),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'Latitude',
                      controller: model.latController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      errorText: model.errorFor('lat'),
                      onChanged: model.onFieldChanged,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.x1),
                  Expanded(
                    child: AppTextField(
                      label: 'Longitude',
                      controller: model.lngController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: true,
                      ),
                      errorText: model.errorFor('lng'),
                      onChanged: model.onFieldChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Contact'),
              AppTextField(
                label: 'Emergency desk phone',
                hintText: '0803 123 4567',
                controller: model.deskPhoneController,
                keyboardType: TextInputType.phone,
                errorText: model.errorFor('deskPhone'),
                onChanged: model.onFieldChanged,
              ),
              gap,
              AppTextField(
                label: 'Named contact',
                controller: model.contactNameController,
                textCapitalization: TextCapitalization.words,
                errorText: model.errorFor('contactName'),
                onChanged: model.onFieldChanged,
              ),
              gap,
              AppTextField(
                label: 'Contact phone',
                controller: model.contactPhoneController,
                keyboardType: TextInputType.phone,
                errorText: model.errorFor('contactPhone'),
                onChanged: model.onFieldChanged,
              ),
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Capabilities'),
              ChipGroup(
                items: model.capabilityOptions,
                onSelected: model.toggleCapability,
              ),
              if (model.errorFor('capabilities') != null) ...[
                const SizedBox(height: AppSpacing.x1),
                AppText.caption(
                  model.errorFor('capabilities')!,
                  tone: AppTextTone.critical,
                ),
              ],
              const SizedBox(height: AppSpacing.x3),
              const SectionHeader('Opening hours'),
              AppSwitchTile(
                label: 'Open 24 hours, every day',
                valueLabel: model.alwaysOpenLabel,
                value: model.alwaysOpen,
                onChanged: model.setAlwaysOpen,
              ),
              if (!model.alwaysOpen) ...[
                const SizedBox(height: AppSpacing.x1),
                ChipGroup(items: model.dayOptions, onSelected: model.toggleDay),
                const SizedBox(height: AppSpacing.x1),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.secondary(
                        title: model.opensLabel,
                        onPressed: model.pickOpens,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.x1),
                    Expanded(
                      child: AppButton.secondary(
                        title: model.closesLabel,
                        onPressed: model.pickCloses,
                      ),
                    ),
                  ],
                ),
                if (model.errorFor('openingHours') != null)
                  AppText.caption(
                    model.errorFor('openingHours')!,
                    tone: AppTextTone.critical,
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

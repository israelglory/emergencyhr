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
        return AppPage(
          title: model.title,
          bottom: AppButton(
            title: model.saveLabel,
            loading: model.isSaving,
            onPressed: model.save,
          ),
          body: SectionColumn(
            gap: 22,
            children: [
              AppText.headline(model.heading),
              if (model.savedOffline)
                const NoticeBanner(
                  message: FacilityEditorViewModel.offlineNotice,
                  icon: Icons.cloud_off_outlined,
                ),
              SectionColumn(
                gap: 14,
                children: [
                  AppTextField(
                    label: 'Hospital name',
                    controller: model.nameController,
                    textCapitalization: TextCapitalization.words,
                    errorText: model.errorFor('name'),
                    onChanged: model.onFieldChanged,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppText.label('Type'),
                      const SizedBox(height: 6),
                      SegmentPicker(
                        items: model.typeOptions,
                        onSelected: model.setType,
                      ),
                    ],
                  ),
                  AppTextField(
                    label: 'Address',
                    controller: model.addressController,
                    textCapitalization: TextCapitalization.words,
                    errorText: model.errorFor('address'),
                    onChanged: model.onFieldChanged,
                  ),
                  AppDropdown<String>(
                    label: 'Area',
                    value: model.area,
                    options: model.areaOptions,
                    onSelected: model.setArea,
                  ),
                ],
              ),
              _Group(
                title: 'Map pin',
                child: AppCard(
                  child: SectionColumn(
                    gap: AppSpacing.small,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 20,
                            color: context.palette.primaryText,
                          ),
                          const SizedBox(width: AppSpacing.tight),
                          Expanded(child: AppText.subtitle(model.pinLabel)),
                        ],
                      ),
                      AppButton(
                        title: 'Use my current location',
                        size: AppButtonSize.medium,
                        loading: model.isLocating,
                        onPressed: model.useMyLocation,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Latitude',
                              controller: model.latController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                              errorText: model.errorFor('lat'),
                              onChanged: model.onFieldChanged,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.tight),
                          Expanded(
                            child: AppTextField(
                              label: 'Longitude',
                              controller: model.lngController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: true,
                                  ),
                              errorText: model.errorFor('lng'),
                              onChanged: model.onFieldChanged,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _Group(
                title: 'Contact',
                gap: 14,
                child: SectionColumn(
                  gap: 14,
                  children: [
                    AppTextField(
                      label: 'Emergency desk phone',
                      hintText: '0803 000 0000',
                      controller: model.deskPhoneController,
                      keyboardType: TextInputType.phone,
                      errorText: model.errorFor('deskPhone'),
                      onChanged: model.onFieldChanged,
                    ),
                    AppTextField(
                      label: 'Named contact',
                      controller: model.contactNameController,
                      textCapitalization: TextCapitalization.words,
                      errorText: model.errorFor('contactName'),
                      onChanged: model.onFieldChanged,
                    ),
                    AppTextField(
                      label: 'Contact phone',
                      hintText: '0805 000 0000',
                      controller: model.contactPhoneController,
                      keyboardType: TextInputType.phone,
                      errorText: model.errorFor('contactPhone'),
                      onChanged: model.onFieldChanged,
                    ),
                  ],
                ),
              ),
              _Group(
                title: 'Capabilities',
                gap: AppSpacing.x1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CheckboxGrid(
                      items: model.capabilityOptions,
                      onToggle: model.toggleCapability,
                    ),
                    if (model.errorFor('capabilities') != null) ...[
                      const SizedBox(height: 6),
                      AppText.caption(
                        model.errorFor('capabilities')!,
                        tone: AppTextTone.critical,
                      ),
                    ],
                  ],
                ),
              ),
              _Group(
                title: 'Opening hours',
                child: AppCard(
                  child: SectionColumn(
                    gap: AppSpacing.small,
                    children: [
                      MergeSemantics(
                        child: Row(
                          children: [
                            const Expanded(
                              child: AppText.subtitle(
                                'Open 24 hours, every day',
                              ),
                            ),
                            Switch(
                              value: model.alwaysOpen,
                              onChanged: model.setAlwaysOpen,
                            ),
                          ],
                        ),
                      ),
                      if (!model.alwaysOpen) ...[
                        DayPicker(
                          items: model.dayOptions,
                          onToggle: model.toggleDay,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton.secondary(
                                title: model.opensLabel,
                                size: AppButtonSize.medium,
                                onPressed: model.pickOpens,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.tight),
                            Expanded(
                              child: AppButton.secondary(
                                title: model.closesLabel,
                                size: AppButtonSize.medium,
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({
    required this.title,
    required this.child,
    this.gap = AppSpacing.small,
  });

  final String title;
  final Widget child;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(header: true, child: AppText.caps(title)),
        SizedBox(height: gap),
        child,
      ],
    );
  }
}

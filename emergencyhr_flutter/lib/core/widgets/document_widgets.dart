import 'package:flutter/material.dart';

import '../constants/dimens.dart';
import '../theme/app_palette.dart';
import '../theme/theme.dart';
import 'app_button.dart';
import 'app_text.dart';
import 'icon_tile.dart';

/// An uploaded document in a card row: icon, file name, "Photo · 1.2 MB",
/// and an optional remove button.
class DocumentRow extends StatelessWidget {
  const DocumentRow({
    super.key,
    required this.name,
    required this.meta,
    this.onRemove,
  });

  final String name;
  final String meta;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 10, onRemove == null ? 16 : 4, 10),
        child: Row(
          children: [
            const IconTile(Icons.description_outlined),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.label.copyWith(color: p.text),
                  ),
                  AppText.caption(meta),
                ],
              ),
            ),
            if (onRemove != null)
              IconButton(
                tooltip: 'Remove file',
                color: p.textSecondary,
                icon: const Icon(Icons.close),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}

/// Photograph (phones only) and Upload, side by side.
class DocumentButtons extends StatelessWidget {
  const DocumentButtons({
    super.key,
    required this.canUseCamera,
    required this.onPhotograph,
    required this.onUpload,
    this.loading = false,
  });

  final bool canUseCamera;
  final VoidCallback onPhotograph;
  final VoidCallback onUpload;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (canUseCamera) ...[
          Expanded(
            child: AppButton.secondary(
              title: 'Photograph',
              icon: Icons.photo_camera_outlined,
              size: AppButtonSize.medium,
              loading: loading,
              onPressed: onPhotograph,
            ),
          ),
          const SizedBox(width: AppSpacing.tight),
        ],
        Expanded(
          child: AppButton.secondary(
            title: 'Upload',
            icon: Icons.upload_outlined,
            size: AppButtonSize.medium,
            loading: loading && !canUseCamera,
            onPressed: onUpload,
          ),
        ),
      ],
    );
  }
}

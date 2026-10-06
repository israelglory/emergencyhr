import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  final Branch branch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCall;
  final VoidCallback onCopy;

  const BranchCard({
    super.key,
    required this.branch,
    required this.onEdit,
    required this.onDelete,
    required this.onCall,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final canEdit = appGlobals.canEdit;
    final canDelete = appGlobals.canDelete;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: branch.isMainBranch
              ? AppColors.buttonColor.withValues(alpha: 0.5)
              : Colors.grey.shade200,
          width: branch.isMainBranch ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: canEdit ? onEdit : null,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon + Name + Main Tag + Menu
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store Icon Avatar
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: branch.isMainBranch
                            ? AppColors.buttonColor.withValues(alpha: 0.12)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        branch.isMainBranch
                            ? Icons.storefront
                            : Icons.store_outlined,
                        size: 22,
                        color: branch.isMainBranch
                            ? AppColors.buttonColor
                            : AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Name and Main badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  branch.name,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (branch.isMainBranch) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.buttonColor.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.buttonColor.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 11,
                                    color: AppColors.buttonColor,
                                  ),
                                  SizedBox(width: 3),
                                  AppText(
                                    'Main Branch',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.buttonColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Menu Button
                    PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.grey,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (action) {
                        switch (action) {
                          case 'edit':
                            onEdit();
                            break;
                          case 'call':
                            onCall();
                            break;
                          case 'copy':
                            onCopy();
                            break;
                          case 'delete':
                            onDelete();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        if (canEdit)
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 8),
                                AppText('Edit Branch', fontSize: 13),
                              ],
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'call',
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 18,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 8),
                              AppText('Call Phone', fontSize: 13),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'copy',
                          child: Row(
                            children: [
                              Icon(
                                Icons.copy_outlined,
                                size: 18,
                                color: Colors.black87,
                              ),
                              SizedBox(width: 8),
                              AppText('Copy Details', fontSize: 13),
                            ],
                          ),
                        ),
                        if (canDelete) ...[
                          const PopupMenuDivider(),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                AppText(
                                  'Delete',
                                  fontSize: 13,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(height: 1),
                const SizedBox(height: 10),

                // Address Row
                if (branch.address.isNotEmpty) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: AppText(
                          branch.address,
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],

                // Phone Row
                if (branch.phone.isNotEmpty)
                  GestureDetector(
                    onTap: onCall,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 15,
                          color: AppColors.buttonColor,
                        ),
                        const SizedBox(width: 6),
                        AppText(
                          branch.phone,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

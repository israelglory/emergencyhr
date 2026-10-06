import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:emergencyhr_flutter/data/model/model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final AppUser user;
  final String branchName;
  final VoidCallback onToggleStatus;
  final VoidCallback onCopyEmail;
  final VoidCallback onCopyDetails;

  const UserCard({
    super.key,
    required this.user,
    required this.branchName,
    required this.onToggleStatus,
    required this.onCopyEmail,
    required this.onCopyDetails,
  });

  String _getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
  }

  Color _getRoleColor(String role) {
    switch (role.toUpperCase()) {
      case 'ROLE_ADMIN':
      case 'ADMIN':
        return const Color(0xFF6C5CE7);
      case 'ROLE_STAFF':
      case 'STAFF':
        return const Color(0xFF09B9DF);
      case 'ROLE_SALES_BOY':
      case 'ROLE_SALE_BOY':
      case 'SALE_BOY':
      case 'SALES_BOY':
        return const Color(0xFFFF7675);
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleColor = _getRoleColor(user.role);
    final isSelf =
        appGlobals.user?.id == user.id ||
        appGlobals.user?.email.toLowerCase() == user.email.toLowerCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: user.isActive ? Colors.grey.shade200 : Colors.red.shade100,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Avatar + Info + Popup Menu
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 22,
                  backgroundColor: roleColor.withValues(alpha: 0.15),
                  child: Text(
                    _getInitials(user.fullName),
                    style: TextStyle(
                      color: roleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Name & Email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              user.fullName,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: user.isActive
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isSelf) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const AppText(
                                'You',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      AppText(
                        user.email,
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Popup menu
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
                      case 'toggle':
                        if (!isSelf) onToggleStatus();
                        break;
                      case 'copy_email':
                        onCopyEmail();
                        break;
                      case 'copy_details':
                        onCopyDetails();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    if (!isSelf)
                      PopupMenuItem(
                        value: 'toggle',
                        child: Row(
                          children: [
                            Icon(
                              user.isActive
                                  ? Icons.block_outlined
                                  : Icons.check_circle_outline,
                              size: 18,
                              color: user.isActive
                                  ? Colors.red
                                  : Colors.green.shade700,
                            ),
                            const SizedBox(width: 8),
                            AppText(
                              user.isActive
                                  ? 'Deactivate User'
                                  : 'Activate User',
                              fontSize: 13,
                              color: user.isActive
                                  ? Colors.red
                                  : Colors.green.shade700,
                            ),
                          ],
                        ),
                      ),
                    const PopupMenuItem(
                      value: 'copy_email',
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 8),
                          AppText('Copy Email', fontSize: 13),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'copy_details',
                      child: Row(
                        children: [
                          Icon(
                            Icons.copy_outlined,
                            size: 18,
                            color: Colors.black87,
                          ),
                          SizedBox(width: 8),
                          AppText('Copy User Details', fontSize: 13),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),

            // Bottom Badges Row: Role + Branch + Status Switch/Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Role & Branch pills
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      // Role Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: roleColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: roleColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: AppText(
                          UserRoles.getRoleLabel(user.role),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: roleColor,
                        ),
                      ),

                      // Branch Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.storefront_outlined,
                              size: 12,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            AppText(
                              branchName,
                              fontSize: 11,
                              color: Colors.grey.shade800,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Pill
                GestureDetector(
                  onTap: isSelf ? null : onToggleStatus,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: user.isActive
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: user.isActive
                            ? Colors.green.shade300
                            : Colors.red.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: user.isActive
                                ? Colors.green.shade600
                                : Colors.red.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AppText(
                          user.isActive ? 'Active' : 'Disabled',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: user.isActive
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

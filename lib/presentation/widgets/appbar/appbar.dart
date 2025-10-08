import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/utils/divice/divice_utils.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCustom(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () {
                context.pop(true);
              },
              icon: const Icon(Icons.arrow_back))
          : leadingIcon != null
              ? IconButton(
                  onPressed: () => leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.getScreenHeight());
}

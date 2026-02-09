import 'package:flutter/material.dart';

import '../../constants/app_text_string.dart';
import '../color/app_colors.dart';

class SharedConfirmationDialog extends StatefulWidget {
  const SharedConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.onConfirm,
    this.icon = Icons.delete_outline,
  });

  final String title;
  final String message;
  final IconData icon;
  final VoidCallback? onConfirm;

  @override
  State<SharedConfirmationDialog> createState() =>
      _SharedConfirmationDialogState();
}

class _SharedConfirmationDialogState extends State<SharedConfirmationDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return FadeTransition(
      opacity: _fade,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.whiteBase,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: size.width * 0.25,
                  height: size.height * 0.12,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.whiteBase, AppColors.lightPink],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(widget.icon, size: 48, color: AppColors.mainBase),
                ),
                const SizedBox(height: 24),
                Text(widget.title, style: textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      if (widget.onConfirm != null) {
                        widget.onConfirm!();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.mainBase, AppColors.lightPink],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          AppTextString.confirm,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.gray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppTextString.cancel,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray,
                      ),
                    ),
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

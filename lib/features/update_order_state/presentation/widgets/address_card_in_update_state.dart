import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../core/gen/assets.gen.dart';
import '../../../../../../../core/style/color/app_colors.dart';
import '../../../../core/constants/app_text_string.dart';
import '../../../../core/helpers/format_number.dart';

class AddressCardInUpdateState extends StatelessWidget {
  const AddressCardInUpdateState({
    super.key,
    required this.leading,
    required this.title,
    this.address = '',
    required this.phone,
  });

  final Widget leading;
  final String title;
  final String address;
  final String phone;

  void _showCallOptions(BuildContext context) {
    final formattedPhone = formatPhone(phone);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListTile(
            leading: const Icon(Icons.phone, color: AppColors.primary),
            title: Text(
              '${AppTextString.call}  $formattedPhone',
              style: const TextStyle(decoration: TextDecoration.underline),
            ),
            onTap: () {
              Navigator.pop(context);
              _makeCall();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _makeCall() async {
    final uri = Uri(scheme: 'tel', path: formatPhone(phone));
    if (await canLaunchUrl(uri)) launchUrl(uri);
  }

  Future<void> _openWhatsApp() async {
    final formatted = formatPhone(phone).replaceFirst('+', '');
    final uri = Uri.parse('https://wa.me/$formatted');
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightTextSecondary, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          leading,
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              if (address.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      address,
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () => _showCallOptions(context),
            child: const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.phone, size: 16, color: AppColors.primary),
            ),
          ),
          InkWell(
            onTap: () => _openWhatsApp(),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                Assets.icons.whatsapp.path,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

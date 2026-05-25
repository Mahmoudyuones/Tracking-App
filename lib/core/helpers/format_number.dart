String formatPhone(String phone) {
  final cleaned = phone.trim();
  if (cleaned.startsWith('+')) return cleaned;
  if (cleaned.startsWith('20')) return '+$cleaned';
  return '+20$cleaned';
}

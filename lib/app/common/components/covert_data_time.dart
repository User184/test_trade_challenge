String convertDataTime(DateTime dateTime) {
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  final year = dateTime.year;

  return '$day.$month.$year';
}

String convertDataTimeSend(DateTime dateTime) {
  final year = dateTime.year;
  final day = dateTime.day.toString().padLeft(2, '0');
  final month = dateTime.month.toString().padLeft(2, '0');
  return '$day-$month-$year';
}

String convertDataTimeMoney(DateTime dateTime) {
  final day = dateTime.day;
  final month = dateTime.month;
  final year = dateTime.year;
  final hour = dateTime.hour;
  final minute = dateTime.minute;

  return '$day.$month.$year $hour:$minute';
}

String formatQuantity(double quantity) {
  if (quantity.truncate() == quantity) {
    return quantity.truncate().toString();
  } else {
    String formatted = quantity.toString();
    if (formatted.endsWith('.0')) {
      formatted = formatted.substring(0, formatted.length - 2);
    }
    return formatted;
  }
}

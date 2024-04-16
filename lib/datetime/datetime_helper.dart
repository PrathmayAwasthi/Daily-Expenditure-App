// Convert datetime object to readable string ddmmyyyy
String convertDateTimeObjectToString(DateTime dt) {
  String date = dt.day.toString();
  if (date.length == 1) {
    date = '0' + date;
  }
  String month = dt.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }
  String year = dt.year.toString();

  String ddmmyyyy = date + month + year;
  return ddmmyyyy;
}

String currentTime(DateTime dt) {
  String hr = dt.hour.toString();
  if (hr.length == 1) {
    hr = '0' + hr;
  }
  String min = dt.minute.toString();
  if (min.length == 1) {
    min = '0' + min;
  }

  String ct = hr + min;
  return ct;
}

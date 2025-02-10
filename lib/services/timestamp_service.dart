import 'package:intl/intl.dart';

// ini buat dapetin data waktu secara realtime
void setDateTime(Function(String, String, String) onDateTimeSet) {
  var dateNow = DateTime.now();
  var dateFormat = DateFormat('dd mm yyyy');
  var dateTime = DateFormat('hh:mm:ss');

  String date = dateFormat.format(dateNow);
  String time = dateTime.format(dateNow);
  String currentDate = '$date | $time';

  onDateTimeSet(date, time, currentDate);
}

// ini buat ngeset status kehadiran
void setAttendanceStatus(Function(String) onStatusSet) {
  var dateNow = DateTime.now();
  var hour = int.parse(DateFormat('hh').format(dateNow));
  var minute = int.parse(DateFormat('mm').format(dateNow));

  String attendanceStatus;
  // ini menentukan status kehadiran berdasarkan jam sekarang
  if (hour < 7 || (hour == 7 && minute == 00)) { // sebelum/jam 7: Attend
    attendanceStatus = "Attend";
  } else if (hour > 7 || (hour == 7 && minute >= 01)) {  // lewat jam 7: Late
    attendanceStatus = "Late";
  } else {
    attendanceStatus = "Absent"; // sisanya dianggap Absent
  }

  onStatusSet(attendanceStatus);
}
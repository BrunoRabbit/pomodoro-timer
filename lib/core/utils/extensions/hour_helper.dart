extension HourHelper on num {
  String toMinSec() {
    int seconds = this as int;
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  String secToHourMin() {
    double seconds = this as double;

    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String hourString = '$hours hrs';
    String minuteString = '${minutes.toString().padLeft(2, '0')} min';

    return '$hourString $minuteString';
  }
}
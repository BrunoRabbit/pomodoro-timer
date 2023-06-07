extension HourHelper on int {
  String toMinSec() {
    return '${(this ~/ 60).toString().padLeft(2, '0')}:${(this % 60).toString().padLeft(2, '0')}';
  }
}
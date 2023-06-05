extension HourHelper on int {
  String toMinSec() {
    return '${(this ~/ 10).toString().padLeft(2, '0')}:${(this % 10).toString().padLeft(2, '0')}';
  }
}
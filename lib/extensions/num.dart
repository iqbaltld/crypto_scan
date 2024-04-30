extension Formatting on num {
  String formatNumber() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}k';
    } else {
      return toStringAsFixed(0);
    }
  }
}

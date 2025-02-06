extension OnDouble on double {
  String get asIntString {
    return toInt() == this ? toInt().toString() : toString();
  }

  
}

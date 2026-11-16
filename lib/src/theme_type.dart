enum ThemeType {
  adwaita,
  auto,
  arc,
  breeze,
  elementary,
  flatRemix,
  materia,
  nordic,
  osxArc,
  pop,
  unity,
  vimix,
  yaru,
}

extension ThemeTypeSvgTint on ThemeType {
  /// Whether titlebar SVG assets should be tinted from app brightness.
  bool shouldTintSvgFromBrightness({
    required bool isHovering,
    required bool isActive,
    required String buttonName,
  }) {
    switch (this) {
      case ThemeType.breeze:
      case ThemeType.elementary:
        return true;
      case ThemeType.yaru:
        return !isHovering && !isActive && buttonName != 'close';
      case ThemeType.adwaita:
        return !isHovering && !isActive;
      case ThemeType.auto:
      case ThemeType.arc:
      case ThemeType.flatRemix:
      case ThemeType.materia:
      case ThemeType.nordic:
      case ThemeType.osxArc:
      case ThemeType.pop:
      case ThemeType.unity:
      case ThemeType.vimix:
        return false;
    }
  }
}

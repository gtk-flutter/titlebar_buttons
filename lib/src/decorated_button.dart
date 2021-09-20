import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:window_decorations/src/theme_type.dart';

class DecoratedMinimizeButton extends StatelessWidget {
  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

  const DecoratedMinimizeButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawDecoratedWindowButton(
      type: type,
      name: 'minimize',
      onPressed: onPressed,
      width: width,
      height: height,
    );
  }
}

class DecoratedMaximizeButton extends StatelessWidget {
  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

  const DecoratedMaximizeButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawDecoratedWindowButton(
      type: type,
      name: 'maximize',
      onPressed: onPressed,
      width: width,
      height: height,
    );
  }
}

class DecoratedCloseButton extends StatelessWidget {
  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

  const DecoratedCloseButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawDecoratedWindowButton(
      type: type,
      name: 'close',
      onPressed: onPressed,
      width: width,
      height: height,
    );
  }
}

class RawDecoratedWindowButton extends StatefulWidget {
  const RawDecoratedWindowButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.name,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType type;

  /// Specify the name of the button that
  /// you are trying to create
  final String name;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

  @override
  State<RawDecoratedWindowButton> createState() =>
      _RawDecoratedWindowButtonState();
}

class _RawDecoratedWindowButtonState extends State<RawDecoratedWindowButton> {
  bool isHovering = false;
  bool isActive = false;
  late String theme = '';

  void getTheme() async {
    GSettings settings = GSettings('org.gnome.desktop.interface');
    theme = ((await settings.get('gtk-theme')) as DBusString).value;
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type != ThemeType.auto
        ? widget.type
        : ThemeType.values.firstWhere(
            (element) => (theme).toLowerCase().replaceAll('-', ' ').contains(
                  describeEnum(element).replaceAll('_', ' '),
                ),
            orElse: () => ThemeType.adwaita);
    onEntered(bool hover) => setState(() {
          isHovering = hover;
        });

    onActive(bool hover) => setState(() {
          isActive = hover;
        });

    return MouseRegion(
      onExit: (value) => onEntered(false),
      onHover: (value) => onEntered(true),
      child: GestureDetector(
        onTapDown: (_) => onActive(true),
        onTapCancel: () => onActive(false),
        onTapUp: (_) => onActive(false),
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 15),
          child: SvgPicture.asset(
            'packages/window_decorations/assets/themes/' +
                describeEnum(type).replaceAll('_', '-') +
                (type == ThemeType.pop ||
                        type == ThemeType.arc ||
                        type == ThemeType.materia ||
                        type == ThemeType.united ||
                        type == ThemeType.unity
                    ? Theme.of(context).brightness == Brightness.dark
                        ? '-dark'
                        : '-light'
                    : '') +
                '/' +
                widget.name +
                (isActive
                    ? '-active'
                    : isHovering
                        ? '-hover'
                        : '') +
                '.svg',
            width: widget.width,
            height: widget.height,
            color: (!isHovering &&
                        !isActive &&
                        type == ThemeType.yaru &&
                        widget.name != 'close' ||
                    type == ThemeType.breeze ||
                    !isHovering && !isActive && type == ThemeType.adwaita)
                ? Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black
                : null,
          ),
        ),
      ),
    );
  }
}

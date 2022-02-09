import 'package:change_case/change_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:window_decorations/src/get_theme.dart';
import 'package:window_decorations/src/theme_type.dart';

Widget windowDecor(String name, ThemeType? type, void Function()? onPressed) =>
    RawDecoratedWindowButton(
      name: name,
      type: type,
      onPressed: onPressed,
    );

class DecoratedMinimizeButton extends StatelessWidget {
  const DecoratedMinimizeButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType? type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

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
  const DecoratedMaximizeButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType? type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

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
  const DecoratedCloseButton({
    Key? key,
    this.type = ThemeType.auto,
    required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  /// Specify the type of theme you want to be
  /// used for the window decorations
  final ThemeType? type;

  /// Specify a nullable onPressed callback
  /// used when this button is pressed
  final VoidCallback? onPressed;

  /// Width of the Button
  final double? width;

  /// Height of the Button
  final double? height;

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
  final ThemeType? type;

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

  @override
  void initState() {
    super.initState();
    getTheme().then((value) => setState(() => theme = value));
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.type != null && widget.type != ThemeType.auto
        ? widget.type!
        : ThemeType.values.firstWhere(
            (element) => theme.toParamCase().contains(
                  describeEnum(element).toParamCase(),
                ),
            orElse: () => ThemeType.adwaita,
          );

    final themeName = describeEnum(type).toParamCase();
    final themeColor = type == ThemeType.pop ||
            type == ThemeType.arc ||
            type == ThemeType.materia ||
            type == ThemeType.unity
        ? Theme.of(context).brightness == Brightness.dark
            ? '-dark'
            : '-light'
        : '';

    final state = isActive
        ? '-active'
        : isHovering
            ? '-hover'
            : '';

    final fileName = '${widget.name}$state.svg';

    final themePath =
        'packages/window_decorations/assets/themes/$themeName$themeColor/$fileName';

    void onEntered({required bool hover}) => setState(() {
          isHovering = hover;
        });

    void onActive({required bool hover}) => setState(() {
          isActive = hover;
        });

    return MouseRegion(
      onExit: (value) => onEntered(hover: false),
      onHover: (value) => onEntered(hover: true),
      child: GestureDetector(
        onTapDown: (_) => onActive(hover: true),
        onTapCancel: () => onActive(hover: false),
        onTapUp: (_) => onActive(hover: false),
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.all(4),
          constraints: const BoxConstraints(minWidth: 15),
          child: SvgPicture.asset(
            themePath,
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

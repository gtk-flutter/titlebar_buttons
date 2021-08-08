## Window Decorations

A package which provides most of the window decorations from linux themes.

## Features
- Easier to use and implement
- Native looking window buttons for close, minimize and maximize actions
<!-- ## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package. -->

## Usage

Let's say you want a minimize button with look and feel of yaru theme, you can do that with `DecoratedMinimizeButton` which comes with a type property which accepts `ThemeType`

```dart
DecoratedMinimizeButton(
    type: ThemeType.yaru,
    onPressed: () {},
),
```

Similarly you can use ```DecoratedCloseButton``` for close button and ```DecoratedMaximizeButton``` for maximize button.

## Additional information

- This package is GPL-3.0 licensed due to the fact that it uses various GPL-3 themes buttons.

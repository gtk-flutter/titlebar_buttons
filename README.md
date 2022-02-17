## Titlebar buttons

A package which provides most of the titlebar buttons from windows, linux and macos.

![materia](https://user-images.githubusercontent.com/41370460/130425898-8967115b-ba44-4d9a-8fc6-c63f878074c1.png)  
![breeze](https://user-images.githubusercontent.com/41370460/130425904-0ac93a49-578f-4f6b-8dc1-dd64e57edf0b.png)  
![osx_arc](https://user-images.githubusercontent.com/41370460/130425907-ba7321f9-fc87-4542-9197-0336e727d5a3.png)  
![yaru](https://user-images.githubusercontent.com/41370460/130425920-a8f7cffd-0a66-4117-8617-1a17323669a6.png)


## Features
- Easier to use and implement
- Native looking titlebar buttons for close, minimize and maximize actions

## Usage

Let's say you want a minimize button with look and feel of yaru theme, you can do that with `DecoratedMinimizeButton` which comes with a type property which accepts `ThemeType` (defaults to auto)

```dart
DecoratedMinimizeButton(
    type: ThemeType.yaru,
    onPressed: () {},
),
```

Similarly you can use ```DecoratedCloseButton``` for close button and ```DecoratedMaximizeButton``` for maximize button.

## LICENSE

`Mozilla Public License 2.0`

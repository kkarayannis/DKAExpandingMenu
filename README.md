# DKAExpandingMenu

## Screenshot

<img src="https://raw.githubusercontent.com/kkarayannis/DKAExpandingMenu/master/Assets/demo1.gif"/>
## Installation

DKAExpandingMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`pod "DKAExpandingMenu"`

## Usage

Create a DKAExpandingMenu object and add it to your view. You need to supply it an array of UIViews that will show when the DKAExpandingMenu is tapped on.
`expandingMenu.buttons = @[button1, button2, button3, button4];`

There are several parameters you can customize.
By default the button is a circle, but you can change it to be a square (or half and half) by setting the following 2 properties:

`expandingMenu.topBorder.type = DKABorderEndTypeSquare;`
`expandingMenu.bottomBorder.type = DKABorderEndTypeCircle;`

You can set the direction in which the DKAExpandingMenu expands. Set `self.expandingMenu.direction` to one of the following:

`DKAExpandingMenuDirectionUp`

`DKAExpandingMenuDirectionRight`

`DKAExpandingMenuDirectionDown`

`DKAExpandingMenuDirectionLeft`

The default is down.
    
There is also a delegate protocol which you can implement if you want to be notified when the DKAExpandingMenu expands and contracts.

`(void) expandingMenuWillExpand:(DKAExpandingMenu *)expandingMenu;`

`(void) expandingMenuDidExpand:(DKAExpandingMenu *)expandingMenu;`

`(void) expandingMenuWillContract:(DKAExpandingMenu *)expandingMenu;`

`(void) expandingMenuDidContract:(DKAExpandingMenu *)expandingMenu;`

## Requirements

Requires iOS 7 and ARC

## Author

Konstadinos Karayannis, @kkarayannis

## License

DKAExpandingMenu is available under the MIT license. See the LICENSE file for more info.


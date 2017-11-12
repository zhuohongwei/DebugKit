# DebugKit
A drop-in UIView extension for debugging views

## How to use
Copy UIView+DebugKit.swift into your project. In `viewDidLoad`, add `view.inspectWithTap()` if you want to activate the menu by tapping on the view. If you want to activate the menu by long press, use `inspectWithLongPress()`. Don't forget to remove the line of code when you are done with debugging.

## Sample screens
After adding the line of code and running the project, a contextual menu appears when the view is tapped or long pressed. If the view is a subclass of `UIScrollView`, additional properties like `adjustedContentInset` and `contentInset` can be inspected.

![simulator screen shot - iphone x - 2017-11-12 at 10 58 27](https://user-images.githubusercontent.com/4169262/32695653-99fb8dc6-c79c-11e7-84d9-15447b1fa1c4.png)

![simulator screen shot - iphone 8 plus - 2017-11-12 at 10 56 09](https://user-images.githubusercontent.com/4169262/32695654-9a5572d2-c79c-11e7-8a10-3a5163a8114f.png)

![simulator screen shot - iphone x - 2017-11-12 at 11 00 07](https://user-images.githubusercontent.com/4169262/32695649-992986aa-c79c-11e7-92c6-339144655b7a.png)

![simulator screen shot - iphone x - 2017-11-12 at 10 59 58](https://user-images.githubusercontent.com/4169262/32695650-9962f1c4-c79c-11e7-92aa-f0b78fe71487.png)

![simulator screen shot - iphone x - 2017-11-12 at 10 59 27](https://user-images.githubusercontent.com/4169262/32695651-9996625c-c79c-11e7-8d80-2fd0e06179a2.png)

![simulator screen shot - iphone x - 2017-11-12 at 10 58 42](https://user-images.githubusercontent.com/4169262/32695652-99c7914c-c79c-11e7-9c4f-23708b968f25.png)

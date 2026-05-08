# SnapSheet
A lightweight and customizable bottom sheet library for UIKit built with Swift.
SnapSheet makes it easy to present modern bottom sheets with smooth animations, rounded corners, and a dimmed background — similar to native iOS sheets.

---

## ✨ Features

- Simple UIKit integration
- Custom height support
- Rounded corner presentation
- Background dimming view
- Tap outside to dismiss
- Lightweight and fast
- Swift Package Manager support

---

## 📦 Installation

### Swift Package Manager

Add SnapSheet to your project using Xcode:

1. Open your project in Xcode
2. Go to **File → Add Packages**
3. Enter the repository URL: 
```
https://github.com/heyitsxed/SnapSheet
```

4. Select **Up to Next Major Version**
5. Click **Add Package**

## 🚀 Usage

```swift
import SnapSheet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func presentSheet() {
        let vc = YourViewController()

        let height: CGFloat = 400
        let percent = height / UIScreen.main.bounds.height

        let sheet = SnapSheetController(
            contentViewController: vc,
            height: .fraction(percent)
        )

        present(sheet, animated: true)
    }
}
```
## 📏 Height Configuration
### Fractional Height (Recommended)
```
.height(.fraction(0.5)) // 50% of screen height
.height(.fraction(0.8)) // 80% of screen height
```
### Fixed Height
```
.height(.fixed(400))
.height(.fixed(600))
```

## 📱 Video Preview
A quick preview of SnapSheet in action:
- Smooth bottom sheet presentation
- Fractional height support
- Drag-to-dismiss interaction

https://github.com/user-attachments/assets/dc1c08b6-29ad-416b-b206-060c3d5234ec

## ⚙️ Requirements
iOS 15+
Swift 5.9+

## 🤝 Contributing
Feel free to open issues or submit pull requests to improve SnapSheet.

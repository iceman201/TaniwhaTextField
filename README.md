# TaniwhaTextField

<p align="center">
<img src="https://github.com/iceman201/TaniwhaTextField/blob/master/Example/taniwhaTextfield.png?raw=true" alt="logo"/>
</p>


[![Version](https://img.shields.io/cocoapods/v/TaniwhaTextField.svg?style=flat)](http://cocoapods.org/pods/TaniwhaTextField)
[![License](https://img.shields.io/cocoapods/l/TaniwhaTextField.svg?style=flat)](http://cocoapods.org/pods/TaniwhaTextField)
[![Platform](https://img.shields.io/cocoapods/p/TaniwhaTextField.svg?style=flat)](http://cocoapods.org/pods/TaniwhaTextField)
[![Issues](https://img.shields.io/github/issues/iceman201/TaniwhaTextField.svg?style=flat)](https://github.com/iceman201/TaniwhaTextField/issues?state=open) 

## Introduction
TaniwhaTextField is a lightweight and beautiful swift textfield framework. And also you can highly customize it.

## Usage
#### Programme
```
import TaniwhaTextField

class ViewController: UIViewController {

    @IBOutlet var taniwha: TaniwhaTextField!
    
    @IBOutlet var marimari: TaniwhaTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taniwha.placeholder = "Tena Koe"
        marimari.placeholder = "Kia Ora"
    }
}

```
#### Storyboard
![image](https://user-images.githubusercontent.com/5027957/28316984-274beb06-6c19-11e7-9357-1a8f0793c2aa.png)



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## SPEC

Swift 3.0
support up iOS 8 above


## Installation

TaniwhaTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TaniwhaTextField"
```

## Author

iceman201, liguo@jiao.co.nz

## License

TaniwhaTextField is available under the MIT license. See the [LICENSE](https://github.com/iceman201/TaniwhaTextField/blob/master/LICENSE) file for more info.

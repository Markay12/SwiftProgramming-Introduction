# Tab View

## What is Tab View? 

Tab view allows the users to switch between different views by clicking on the tabs. 

An example of tab view can be when you are on Instagram and you want to switch between the home page, search page, and profile page.

## Table of Content

1. [How to use Tab View](#how-to-use-tab-view)
2. [How to create a Tab View](#how-to-create-a-tab-view)
3. [How to add a Tab View to a View](#how-to-add-a-tab-view-to-a-view)


## How to use Tab View

To create a tab view we will first start with creating a new SwiftUI View. To create a new view press  `CMD+N`  and select  `SwiftUI View`  and name it  `TabViewExample`. 

Once you have the `TabViewExample` we can now start creating the tab view.

This should be the code for the `TabViewExample`:
```swift
    import SwiftUI

    struct TabViewExample: View {
        var body: some View {
            Text("Hello, World!")
        }
    }

    struct TabViewExample_Previews: PreviewProvider {
        static var previews: some View {
            TabViewExample()
        }
    }
```
Now we can start to add the `TabView` to the `TabViewExample` view.

Creating a Tab View is pretty simple. As you can see from the code below:
```Swift
    TabView {

    }
```

Now we are going to create 3 tabs for baseball teams. 
- The first tab will be the LA Dodgers. We will color the tab blue.
- The second tab will be the Arizona Diamondbacks. We will color the tab red.
- The third tab will be the Pittsburgh Pirates. We will color the tab yellow.
```swift
TabView {
    Color.blue
        .edgesIgnoringSafeArea(.top)
        .tabItem {
            Image(systemName: "baseball.fill")
            Text("LA Dodgers")
        }
        
    Color.red
        .edgesIgnoringSafeArea(.top)
        .tabItem {
            Image(systemName: "baseball.fill")
            Text("Arizona Diamondbacks")
        }
    
    Color.yellow
        .edgesIgnoringSafeArea(.top)    
        .tabItem {
            Image(systemName: "baseball.fill")
            Text("Pittsburgh Pirates")
        }
  }
```


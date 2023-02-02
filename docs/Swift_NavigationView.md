# Navigation View
  
  ## What is Navigation View?
A Navigation View is a container view that manages a stack of views, providing navigation between them. It is commonly used to provide navigation between different screens or views in an iOS application. 


Think of it when you are in an app and you click on a button and it takes you to a new screen. That is a Navigation View. It is also used to provide a navigation bar at the top of the screen. 

## Table of Content

1. [Setup](https://github.com/Markay12/SwiftProgramming-Introduction/blob/nagivationBar/docs/Swift_NavigationView.md#setup)
2. [Navigation Link](https://github.com/Markay12/SwiftProgramming-Introduction/blob/nagivationBar/docs/Swift_NavigationView.md#navigation-link)
3. [Navigation Bar](https://github.com/Markay12/SwiftProgramming-Introduction/blob/nagivationBar/docs/Swift_NavigationView.md#navigation-bar)
4. [Navigation Bar Items](https://github.com/Markay12/SwiftProgramming-Introduction/blob/nagivationBar/docs/Swift_NavigationView.md#navigation-bar)


---

## Setup

To use a Navigation View, you must first import SwiftUI and then create a `Navigation View`. This is done by using the NavigationView struct. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
      // This is where the Navigation View is created
        NavigationView {
          // This is where the content of the Navigation View is created
            Text("This is the first view page you land on")
        }
    }
}
```
It is that simple! Now we can add a Navigation Link to it.
## Navigation Link
### What is a navigation link?

A Navigation Link is a button that is used to navigate to a new view. An example of this is when you click on a button and it takes you to a new screen. This is a Navigation Link.

Now that we have a Navigation View, we can add a Navigation Link to it. This is done by using the `NavigationLink` struct. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
          // This is where the Navigation Link is created which takes you to the second view
          // When you reach the second view, you will see the text "Second View"
            NavigationLink(destination: Text("Second View")) {
              // This is where the content of the Navigation Link is created    
                Text("Go to the second view")
            }
        }
    }
}
```
Now when you click on the text, it will take you to the second view. 
## Navigation Bar

### What is a Navigation Bar?

A Navigation Bar is a bar that is at the top of the screen. It is used to provide navigation between different views. It is also used to provide a title for the view.

Now that we have a Navigation Link, we can add a Navigation Bar to it. This is done by using the `navigationBarTitle()` modifier. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Go to the second view")
            }
            // This will create a Navigation Bar with a title "First View"
            .navigationBarTitle("First View")
        }
    }
}
```

Now we have a Navigation Bar with a title "First View".

## Navigation Bar Items

### What is a Navigation Bar Item?

A Navigation Bar Item is used to add buttons and other items to the Navigation Bar. You can have leading and trailing buttons. Leading buttons are on the left side of the Navigation Bar and trailing buttons are on the right side of the Navigation Bar.

Now that we have a Navigation Bar, we can add Navigation Bar Items to it. This is done by using the `navigationBarItems()` modifier. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Go to the second view")
            }
            .navigationBarTitle("First View")
            // This will add a trailing button to the Navigation Bar
            .navigationBarItems(trailing: Button(action: {
                //  This is the action that will be performed when the button is tapped
                print("Button Tapped")
            }) {
                // This is the text that will be displayed on the button
                Text("Button")
            })
        }
    }
}
```

That is an example for trailing button you can also add a leading button. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Go to the second view")
            }
            .navigationBarTitle("First View")
            // This will add a leading button to the Navigation Bar
            .navigationBarItems(leading: Button(action: {
                print("Button Tapped")
            }) {
                Text("Button")
            })
        }
    }
}
```

---

## Conclusion

In this tutorial, we learned about Navigation View, Navigation Link, Navigation Bar, and Navigation Bar Items. We also learned how to use them in SwiftUI. Using Navigation View, Navigation Link, Navigation Bar, and Navigation Bar Items can be very useful when creating an iOS application. As they are used to provide navigation between different views and screens which is very common in iOS applications.




# Navigation View
  
A Navigation View is a container view that manages a stack of views, providing navigation between them. It is commonly used to provide navigation between different screens or views in an iOS application.

## Table of Content

1. [Setup for XCode]()
2. [Navigation Link]()
3. [Navigation Bar]()
4. [Navigation Bar Items]()

---

## Setup

To use a Navigation View, you must first import SwiftUI and then create a Navigation View. This is done by using the NavigationView struct. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello, World!")
        }
    }
}
```

## Navigation Link

Now that we have a Navigation View, we can add a Navigation Link to it. This is done by using the NavigationLink struct. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Hello, World!")
            }
        }
    }
}
```

## Navigation Bar

Now that we have a Navigation Link, we can add a Navigation Bar to it. This is done by using the navigationBarTitle() modifier. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("First View")
        }
    }
}
```

## Navigation Bar Items

Now that we have a Navigation Bar, we can add Navigation Bar Items to it. This is done by using the navigationBarItems() modifier. This is shown below.

```Swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("Second View")) {
                Text("Hello, World!")
            }
            .navigationBarTitle("First View")
            .navigationBarItems(trailing: Button(action: {
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




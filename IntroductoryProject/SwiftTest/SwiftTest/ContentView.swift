//
//  ContentView.swift
//  SwiftTest
//
//  Created by Mark Ashinhust on 1/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        storyView()
    }
}


struct storyView : View
{
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var greeting: String = "Welcome!"
    @State var imageName: String = ""
    
    var body: some View{
        
        VStack{
            
            HStack{
                
        
                Label("Name: ", systemImage: "bolt.circle")
                
                
                TextField("Name Here", text: $firstName, onEditingChanged: { (changed) in print("Name onEditingChanged - \(changed)")
                    
                })
                
                
                
                
            }
            
            HStack{
                
                Label("Last Name: ", systemImage: "bolt.circle.fill")

                TextField("Last Name Here", text:$lastName, onEditingChanged: {
                    
                    (changed) in print("Last Name onEditingChanged - \(changed)")
                    
                })
                
            }
            
            Spacer()
            
            Button(action: {
                
                self.greeting = "  \(self.firstName) \(self.lastName) \n Welcome to CSE335!"
                
                self.imageName = "ArizonaStateImage"
                
            }) {
                
                Text("Click Me!")
                
            }

            Spacer()
            Spacer()
            
            Text(greeting)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
            
            
            
        }.padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  DelView.swift
//  Lab3_MarkAshinhust
//
//  Created by Mark Ashinhust on 2/24/23.
//

import Foundation
import SwiftUI


struct DelView: View {
    
    //create binding for the movies dictionary and the movie to delete
    @Binding var movies: [Int: (title: String, genre: String, price: Double)]
    @State private var delMovieName = ""
    @State private var movieSelect: Int? //int value of the movie to delete if found
    
    @State private var showDeleteAlert = false
    
    @Binding var moviesID: Int
    
    //to show the movie list for deletion
    @Binding var show: Bool
    
    var body: some View {
        
        VStack {
            List {
                ForEach(movies.filter { movie in
                    if delMovieName.isEmpty {
                        //no search has been made
                        return true
                    }
                    else {
                        //return the search value
                        return movie.value.title.localizedCaseInsensitiveContains(delMovieName)
                    }
                }, id: \.key) { key, value in
                    
                    Button(action: {
                        //get the location of the movie that was chosen to be deleted
                        self.movieSelect = key
                    })
                    {
                        Text(value.title)
                            .accentColor(movieSelect == key ? .red : .black)
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.show = false
                    }) {
                        Text("Back")
                    },
                trailing:
                    HStack {
                        EditButton()
                        Button(action: {
                            self.delMovieName = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
            )
            
            TextField("Search", text: $delMovieName)
                .textFieldStyle(SearchTextStyle())
                .padding(.horizontal)
            
            if let movieSelect = self.movieSelect {
                HStack {
                    Spacer()
                    Button(action: {
                        
                        showDeleteAlert = true
                    })
                    {
                        Text("Delete Movie")
                    }
                    .buttonStyle(MyButtonStyleRed())
                    .alert(isPresented: $showDeleteAlert) {
                                Alert(
                                    title: Text("Delete Movie"),
                                    message: Text("Are you sure you want to delete this movie?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        
                                        if (movies.count == 1)
                                        {
                                            
                                            moviesID = 0
                                            
                                        }
                                        
                                        self.movies.removeValue(forKey: movieSelect) //remove movie by key value
                                        self.movieSelect = nil
                                        self.show = false //don't show the screen anymore
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    Spacer()
                }
                .padding()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

//
//  ContentView.swift
//  Lab3_MarkAshinhust
//
//  Created by Mark Ashinhust on 2/22/23.
//

import SwiftUI

public struct ContentView: View {
    @State private var movies = [Int: (title: String, genre: String, price: Double)]()
    @State private var movieTitle = ""
    @State private var movieGenre = ""
    @State private var moviePrice = ""
    @State private var movieID = 0
    @State private var delMovieName = ""
    @State private var search = ""
    
    
    //For delete pop-up view
    @State private var showDelView = false
    
    //For edit pop-up View
    @State private var showEditView = false
    @State private var editMovieName = ""
    @State private var selectedMovieIndex = -1
    
    //For list pop-up view
    @State private var showListView = false
    
    
    //search alert
    @State private var showSearchAlert = false
    @State private var searchText = ""
    
    
    
    var listMovies: [Int: (title: String, genre: String, price: Double)]
    {
        if search.isEmpty
        {
            
            //return list if nothing written
            return movies
            
            
        }
        else
        {
            //return what is searched for
            return movies.filter{ $0.value.title.localizedCaseInsensitiveContains(search) }
            
            
        }
        
        
    }
    
    
    public var body: some View {
        NavigationView {
                    
            Form {
                Section(header: Text("Add Movie")) {
                    TextField("Title", text: $movieTitle)
                    TextField("Genre", text: $movieGenre)
                    TextField("Movie Price", text: $moviePrice)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Movies")) {
                    TextField("Search", text: $search)
                        .textFieldStyle(SearchTextStyle())
                    ForEach(listMovies.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        HStack
                        {
                            Text("\(value.title) - Genre: \(value.genre), Price: $\(value.price, specifier: "%.2f")")
                            
                            Spacer()
                            
                            
                        }
                        .onTapGesture {
                            selectedMovieIndex = key
                        }
                        .foregroundColor(selectedMovieIndex == key ? Color.accentColor : Color.primary)
                    }
                }
            }
            
            .navigationBarItems(
                trailing:
                    HStack {
                        HStack(alignment: .center) {
                            Button(action: {
                                self.addMovie()
                            }) {
                                Text("Add")
                            }
                            .buttonStyle(MyButtonStyleBlue())

                            Button(action: {
                                self.showDelView = true
                                selectedMovieIndex = -1 //reset selected movie
                                
                            }) {
                                Text("Del")
                            }
                            .buttonStyle(MyButtonStyleRed())
                            .sheet(isPresented: $showDelView) {
                                DelView(movies: $movies, moviesID: $movieID, show: $showDelView)
                            }
                        }

                        HStack(alignment: .center) {
                            Button(action: {
                                if selectedMovieIndex >= 0 {
                                    self.showEditView = true
                                    
                                    
                                }
                            }) {
                                Text("Edit")
                            }
                            .buttonStyle(MyButtonStyleGreen())
                            .disabled(selectedMovieIndex == -1)
                            .sheet(isPresented: $showEditView) {
                                EditView(movies: $movies, show: $showEditView, selectedMovieIndex: $selectedMovieIndex)
                            }

                            Button(action: {
                                let found = !listMovies.filter { $0.value.title.localizedCaseInsensitiveContains(search) }.isEmpty
                                searchText = found ? "Movie found!" : "Movie not found."
                                showSearchAlert = true

                            }) {
                                Text("Search")
                            }
                            .alert(isPresented: $showSearchAlert)
                            {
                                Alert(title: Text("Movie Searched"),
                                      message: Text(searchText),
                                      primaryButton: .destructive(Text("Dismiss"))
                                      {
                                        showSearchAlert = false
                                      }, secondaryButton: .cancel()
                                )
                            }
                            .buttonStyle(MyButtonStyleGreen())

                            Button(action: {
                                self.showListView = true
                            }) {
                                Text("List")
                            }
                            .buttonStyle(MyButtonStyleOrange())
                            .disabled(movies.count <= 0)
                            .sheet(isPresented: $showListView) {
                                ListMovies(movies: $movies, show: $showListView)
                            }
                        }
                    }
            )


            
            
        }
    }
    
    
    
    func addMovie() {
        if let price = Double(moviePrice) {
            movies[movieID] = (title: movieTitle, genre: movieGenre, price: price)
            movieTitle = ""
            movieGenre = ""
            moviePrice = ""
            movieID += 1
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

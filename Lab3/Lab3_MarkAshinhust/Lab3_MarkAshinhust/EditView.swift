//
//  EditView.swift
//  Lab3_MarkAshinhust
//
//  Created by Mark Ashinhust on 2/23/23.
//

import SwiftUI

struct EditView: View {
    @Binding var movies: [Int: (title: String, genre: String, price: Double)]
    @Binding var show: Bool
    
    @State private var movieTitle = ""
    @State private var movieGenre = ""
    @State private var moviePrice = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    @Binding var selectedMovieIndex: Int

    
    var selectedMovie: (key: Int, value: (title: String, genre: String, price: Double)) {
        movies.filter{ $0.key == selectedMovieIndex }.first!
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Movie")) {
                    TextField("Title", text: $movieTitle)
                        .onAppear { movieTitle = selectedMovie.value.title }
                    TextField("Genre", text: $movieGenre)
                        .onAppear { movieGenre = selectedMovie.value.genre }
                    TextField("Movie Price", text: $moviePrice)
                        .keyboardType(.decimalPad)
                        .onAppear { moviePrice = String(format: "%.2f", selectedMovie.value.price) }
                }
                
                Section {
                    Button(action: {
                            if let price = Double(moviePrice) {
                                movies[selectedMovieIndex] = (title: movieTitle, genre: movieGenre, price: price)
                            
                            show = false
                        } else {
                            showError = true
                            errorMessage = "Please enter a valid price"
                        }
                    }) {
                        Text("Save Changes")
                    }
                }
            }
            .navigationBarTitle("Edit Movie")
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

//
//  ListMovies.swift
//  Lab3_MarkAshinhust
//
//  Created by Mark Ashinhust on 2/25/23.
//

import Foundation
import SwiftUI

struct ListMovies: View
{
    
    @Binding var movies: [Int: (title: String, genre: String, price: Double)]
    @State private var movieIndex = 0
    
    //label to show when we are at the beginning again
    @State private var showTopLabel = false
    //When we are at the end of the code
    @State private var showLastLabel = false
    
    @Binding var show: Bool
    
    var body: some View
    {
        
        VStack
        {
            HStack
            {
                
                Button(action: {
                    
                    print(movieIndex)
                    
                    if movieIndex > 0
                    {
                        
                        movieIndex -= 1
                        showTopLabel = false
                        showLastLabel = false

                        
                    }
                    
                })
                {
                    
                    Text("Previous")
                    
                }
                .buttonStyle(MyButtonStyleRed())
                
                Button(action: {
                    
                    if movieIndex != movies.count - 1
                    {
                        
                        movieIndex += 1
                        showTopLabel = false

                        
                    }
                    
                    if (movieIndex == movies.count - 1)
                    {
                        
                        showLastLabel = true
                        
                    }
                    
                })
                {
                    
                    Text("Next Movie")
                    
                }
                .buttonStyle(MyButtonStyleBlue())
                
                Button(action: {
                    
                    movieIndex = 0
                    showTopLabel = true
                    showLastLabel = false
                    
                    
                    
                })
                {
                    
                    Text("Top")
                    
                }
                .buttonStyle(MyButtonStyleGreen())
                
                
                
            }
            
            VStack(alignment: .leading, spacing: 20) {
                                
                if let movie = movies[movieIndex]
                {
                    Text(movie.title)
                        .font(.title)
                    Text("Genre: \(movie.genre)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("$\(movie.price, specifier: "%.2f")")
                            .font(.title)
                        Spacer()
                        
                    }
                }
                
            }
            .padding()
            
            if showTopLabel {
                            HStack {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.green)
                                Text("Showing the First Record")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            .padding(.top)
                        }
            
            if showLastLabel
            {
                
                HStack {
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundColor(.red)
                    Text("No More Records")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding(.top)
                
            }
            
            
            Button(action: {
                self.show = false
                showTopLabel = false
                showLastLabel = false

            })
            {
                
                Text("Back")
                
            }
            .buttonStyle(MyButtonStyleBlue())
            .padding(20)


            
        }
        
    }
    
    
}

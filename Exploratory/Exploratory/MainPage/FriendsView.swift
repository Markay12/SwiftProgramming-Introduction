//
//  FriendsView.swift
//  Exploratory
//
//  Created by Mark Ashinhust on 4/13/23.
//

import SwiftUI
import FirebaseFirestore

struct FriendsView: View {
    
    // MARK: Add Variables
    @State private var fetchedUsers: [User] = []
    @State private var searchText: String = ""
    // Dismiss environment
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
     
        NavigationStack
        {
            //List for the users
            List {
                ForEach(fetchedUsers) { user in
                    NavigationLink {
                        
                    } label: {
                        Text(user.username)
                            .font(.callout)
                            .hAlign(.leading)
                    }
                }
                
            }
            .listStyle(.plain)
            // Navigation title and information
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search for a User")
            .searchable(text: $searchText)
            .onSubmit(of: .search, {
                // MARK: Fetch user from Firebase
                Task {
                    await searchUsers()
                }
            })
            .onChange(of: searchText, perform: { newValue in
                if newValue.isEmpty {
                    fetchedUsers = []
                }
            })
            
        }
        
    }
    func searchUsers() async
    {
        do {
            
            let documents = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: searchText)
                .whereField("username", isLessThanOrEqualTo: "\(searchText)\u{f8ff}")
                .getDocuments()
            
            // User information
            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            
            // on Main thread
            await MainActor.run(body: {
                fetchedUsers = users
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}

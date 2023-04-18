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
            // MARK: User List
            List {
                ForEach(fetchedUsers) { user in
                    NavigationLink(destination: ProfileContent(user: user)) {
                        Text(user.username)
                            .font(.callout)
                            .hAlign(.leading)
                    }
                }
                
            }
            .listStyle(.plain)
            // MARK: Navigation Information
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
    
    // MARK: Search user function
    
    func searchUsers() async {
        do {
            let searchTextLowercased = searchText.lowercased() // Convert search text to lowercase
            let documents = try await Firestore.firestore().collection("Users")
                .whereField("username", isGreaterThanOrEqualTo: searchTextLowercased)
                .whereField("username", isLessThanOrEqualTo: "\(searchTextLowercased)\u{f8ff}")
                .getDocuments()
            
            let users = try documents.documents.compactMap { doc -> User? in
                try doc.data(as: User.self)
            }
            
            await MainActor.run {
                fetchedUsers = users
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}



struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}

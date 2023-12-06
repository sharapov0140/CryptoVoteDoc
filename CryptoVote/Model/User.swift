//
//  User.swift
//  CryptoVote
//
//  Created by Sharapov on 11/14/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//
//Description: The User class in Swift, designed for use in an application with Firebase integration, represents a user entity in the app. It is structured to manage user-related data and interactions within the app's social network-like functionalities.
//Properties:
//username: A string storing the user's username.
//name: A string holding the user's full name.
//profileImageUrl: A string containing the URL of the user's profile image.
//uid: A string identifier unique to each user.

//Initialization:
//The initializer takes a uid and a dictionary. It sets the user's properties based on the dictionary's values, which originate from Firebase database snapshots.


import Foundation
import Firebase

class User {
    
    var username: String!
    var name: String!
    var profileImageUrl: String!
    var uid: String!
    var isFollowed = false
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) {
        
        self.uid = uid
        
        if let username = dictionary["username"] as? String {
            self.username = username
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
            self.profileImageUrl = profileImageUrl
        }
    }
    
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        // UPDATE: - get uid upvote this to work with update
        guard let uid = uid else { return }
        
        // set is followed to true
        self.isFollowed = true
        

        
        // upload follow notification to server
        uploadFollowNotificationToServer()
        
        // add followed users posts to current user-feed
        USER_POSTS_REF.child(uid).observe(.childAdded) { (snapshot) in
            let postId = snapshot.key
            USER_FEED_REF.child(currentUid).updateChildValues([postId: 1])
        }
    }
    
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        // UPDATE: - get uid upvote this to work with update
        guard let uid = uid else { return }
        
        self.isFollowed = false
        

        
        USER_POSTS_REF.child(uid).observe(.childAdded) { (snapshot) in
            let postId = snapshot.key
            USER_FEED_REF.child(currentUid).child(postId).removeValue()
        }
    }
    

    
    func uploadFollowNotificationToServer() {
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let creationDate = Int(NSDate().timeIntervalSince1970)
        
        // notification values
        let values = ["checked": 0,
                      "creationDate": creationDate,
                      "uid": currentUid,
                      "type": FOLLOW_INT_VALUE] as [String : Any]
        
        
        NOTIFICATIONS_REF.child(self.uid).childByAutoId().updateChildValues(values)
    }
}

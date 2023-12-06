//
//  Post.swift
//  CryptoVote
//
//  Created by Sharapov on 11/8/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//
//Description: The Post class, defined in the Post.swift file of the CryptoVote application, encapsulates the properties and behaviors of a cryptocurrency-related post. It integrates Firebase for backend operations and uses UIKit for image handling.
//Properties: The class includes several properties to represent a post:
//caption: A string for the post's caption.
//symbol: A string identifier, likely representing a cryptocurrency symbol.
//upvotes: An integer tracking the number of upvotes a post has received.
//price: A double representing the price of the cryptocurrency.
//price_usd: A string indicating the USD price of the cryptocurrency.
//didUpvote: A boolean indicating whether the current user has upvoted the post.
//image: A UIImage, potentially for displaying related visuals.
//postId: A string identifier for the post.
//Initialization: The class initializer takes a symbol and a dictionary. It sets the post's properties based on the dictionary's contents, which likely come from a Firebase database snapshot.
//Upvote Logic: Includes methods adjustUpvotes and removeUpvote to handle upvoting functionality. These methods interact with Firebase to update the post's upvote count and the user's upvote status.
//adjustUpvotes: Adds or removes an upvote for the post, updates the Firebase database accordingly, and triggers a completion handler with the updated upvote count.
//removeUpvote: Removes an upvote from the post, updates the Firebase database, and triggers a completion handler with the updated upvote count.
                                                                                                                                                                                                    
import Firebase
import Foundation





class Post {

    var caption: String!
    var symbol: String!
    var upvotes: Int!
    var price: Double!
    var image = UIImage()
//  var creationDate: Date!
    
    var postId: String!
    var price_usd: String! //
    var didUpvote = false

    init(symbol: String!, dictionary: Dictionary<String, AnyObject>) {

        self.symbol = symbol
        
         
        
        if let caption = dictionary["c"] as? String {
            self.caption = caption
        }

        if let symbol = dictionary["s"] as? String {
            self.symbol = symbol
        }

        if let upvotes = dictionary["v"] as? Int {
            self.upvotes = upvotes
        }
        
        
        
        if let price_usd = dictionary["price_usd"] as? String {
            self.price_usd = price_usd
        }
        if let price = dictionary["price"] as? Double {
            self.price = price
        }
            }
//
    func adjustUpvotes(addUpvote: Bool, completion: @escaping(Int) -> ()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        // UPDATE: Unwrap post id to work with firebase
        
        guard let postId = self.symbol else { return }
        
        if addUpvote {
            USER_UPVOTES_REF.child(currentUid).updateChildValues([postId: 1], withCompletionBlock: { (err, ref) in
          //      self.sendUpvoteNotificationToServer()
                
                POST_UPVOTES_REF.child(postId).updateChildValues([currentUid: 1], withCompletionBlock: { (err, ref) in
                    self.upvotes = self.upvotes + 1
                    self.didUpvote = true
                    POSTS_REF.child(postId).child("v").setValue(self.upvotes)
                    completion(self.upvotes)
                })
            })
        }
        else {
    USER_UPVOTES_REF.child(currentUid).child(postId).observeSingleEvent(of: .value, with: { (snapshot) in
        if snapshot.value is String {
                   //NOTIFICATIONS_REF.child(self.ownerUid).child(notificationID).removeValue(completionBlock: { (err, ref) in
                    
                        self.removeUpvote(withCompletion: { (upvotes) in
                            completion(upvotes)
                        })
             //       })
                } else {
                    self.removeUpvote(withCompletion: { (upvotes) in
                        completion(upvotes)
                    })
                }
            })
        }
    }

    
    
    func removeUpvote(withCompletion completion: @escaping (Int) -> ()) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        USER_UPVOTES_REF.child(currentUid).child(self.symbol).removeValue(completionBlock: { (err, ref) in

            POST_UPVOTES_REF.child(self.symbol).child(currentUid).removeValue(completionBlock: { (err, ref) in
                guard self.upvotes > 0 else { return }
                self.upvotes = self.upvotes - 1
                self.didUpvote = false
                POSTS_REF.child(self.symbol).child("v").setValue(self.upvotes)
                completion(self.upvotes)
            })
        })
    }
}
//
////    func deletePost() {
////        guard let currentUid = Auth.auth().currentUser?.uid else { return }
////
////        Storage.storage().reference(forURL: self.imageUrl ?? "").delete(completion: nil)
////
////        USER_FOLLOWER_REF.child(currentUid).observe(.childAdded) { (snapshot) in
////            let followerUid = snapshot.key
////            USER_FEED_REF.child(followerUid).child(self.postId).removeValue()
////        }
////
////        USER_FEED_REF.child(currentUid).child(postId).removeValue()
////
////        USER_POSTS_REF.child(currentUid).child(postId).removeValue()
////
////        POST_LIKES_REF.child(postId).observe(.childAdded) { (snapshot) in
////            let uid = snapshot.key
////
////            USER_LIKES_REF.child(uid).child(self.postId).observeSingleEvent(of: .value, with: { (snapshot) in
////                guard let notificationId = snapshot.value as? String else { return }
////
////                NOTIFICATIONS_REF.child(self.ownerUid).child(notificationId).removeValue(completionBlock: { (err, ref) in
////
////                    POST_LIKES_REF.child(self.postId).removeValue()
////
////                    USER_LIKES_REF.child(uid).child(self.postId).removeValue()
////                })
////            })
////        }
////
////        let words = caption.components(separatedBy: .whitespacesAndNewlines)
////        for var word in words {
////            if word.hasPrefix("#") {
////
////                word = word.trimmingCharacters(in: .punctuationCharacters)
////                word = word.trimmingCharacters(in: .symbols)
////
////                HASHTAG_POST_REF.child(word).child(postId).removeValue()
////            }
////        }
////
////        COMMENT_REF.child(postId).removeValue()
////        POSTS_REF.child(postId).removeValue()
////    }
//
////    func sendLikeNotificationToServer() {
////        guard let currentUid = Auth.auth().currentUser?.uid else { return }
////        let creationDate = Int(NSDate().timeIntervalSince1970)
////
////        if currentUid != self.ownerUid {
////            let values = ["checked": 0,
////                          "creationDate": creationDate,
////                          "uid": currentUid,
////                          "type": LIKE_INT_VALUE,
////                          "postId": postId] as [String : Any]
////
////            let notificationRef = NOTIFICATIONS_REF.child(self.ownerUid).childByAutoId()
////            notificationRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
////                USER_LIKES_REF.child(currentUid).child(self.postId).setValue(notificationRef.key)
////            })
////        }
////    }
//}


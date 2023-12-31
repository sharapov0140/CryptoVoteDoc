//
//  Constants.swift
//  CryptoVote
//
//  Created by Sharapov on 12/5/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//



import Firebase

// MARK: - Root References

let DB_REF = Database.database().reference()
//let STORAGE_REF = Storage.storage().reference()


// MARK: - Database References

let USER_REF = DB_REF.child("users")

let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")

let POSTS_REF = DB_REF.child("posts")
let USER_POSTS_REF = DB_REF.child("user-posts")

let USER_FEED_REF = DB_REF.child("user-feed")

let USER_UPVOTES_REF = DB_REF.child("user-upvotes")
let POST_UPVOTES_REF = DB_REF.child("post-upvotes")

let COMMENT_REF = DB_REF.child("comments")

let NOTIFICATIONS_REF = DB_REF.child("notifications")

let MESSAGES_REF = DB_REF.child("messages")
let USER_MESSAGES_REF = DB_REF.child("user-messages")
let USER_MESSAGE_NOTIFICATIONS_REF = DB_REF.child("user-message-notifications")

let HASHTAG_POST_REF = DB_REF.child("hashtag-post")

// MARK: - Decoding Values

let UPVOTE_INT_VALUE = 0
let COMMENT_INT_VALUE = 1
let FOLLOW_INT_VALUE = 2
let COMMENT_MENTION_INT_VALUE = 3
let POST_MENTION_INT_VALUE = 4


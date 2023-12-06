////
////  CustomImageView.swift
////  CryptoVote
////
////  Created by Sharapov on 12/5/23.
////  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
////
//
//
//
//import Foundation
//import UIKit
//
//var imageCache = [String: UIImage]()
//
//class CustomImageView: UIImageView {
//    
//    var lastURLUsedToLoadImage: String?
//    
//    func loadImage(urlString: String) {
//        lastURLUsedToLoadImage = urlString
//        
//        if let cachedImage = imageCache[urlString] {
//            self.image = cachedImage
//            return
//        }
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            if let err = err {
//                print("Failed to fetch post image:", err)
//                return
//            }
//            
//            if url.absoluteString != self.lastURLUsedToLoadImage {
//                return
//            }
//            
//            guard let imageData = data else { return }
//            
//            let photoImage = UIImage(data: imageData)
//            
//            imageCache[url.absoluteString] = photoImage
//            
//            DispatchQueue.main.async {
//                self.image = photoImage
//            }
//            
//            }.resume()
//    }
//}
//

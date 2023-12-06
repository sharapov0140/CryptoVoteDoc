//
//  SettingsSection.swift
//  CryptoVote
//
//  Created by Sharapov on 11/14/23.
//  Copyright © 2023 Muzaffar Sharapov. All rights reserved.
//
//Description: The Swift code snippet defines a protocol SectionType and two enums, SettingsSection and SocialOptions, intended for managing settings in an application with Firebase integration. These constructs are typically used to organize and display various options in a settings or configuration section of the app.
//SectionType Protocol:
//This protocol defines a property containsSwitch indicating whether a section contains a toggle switch.
//It also requires conforming types to provide a description (via CustomStringConvertible), which is used for displaying the section's title or label.
//SettingsSection Enum:
//Represents different sections in the app's settings. Currently, it includes only one case, Social.
//Implements CustomStringConvertible to provide a textual description for each section, which aids in user interface rendering.
//The description for Social is set as "Settings".
//SocialOptions Enum:
//Enumerates various options available under the Social section of settings.
//Cases include report, termsOfUsage, termsOfPrivacy, and logout.
//Implements SectionType, meaning it provides a containsSwitch boolean (always false here, indicating these options don't have toggle switches).
//The description provides text for each option. Notably, the logout option dynamically changes to "Log In" or "Log Out" depending on the user's authentication status in Firebase.
                                                                                                                                    
                                                                                                                                    
import Foundation
import Firebase

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
  //  case Communications
    
    var description: String {
        switch self {
        case .Social: return "Settings"
//        case .Communications: return "Communications"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    
    
    case report
    case termsOfUsage
    case termsOfPrivacy
    case logout

    
    var containsSwitch: Bool { return false }
    
    
    var description: String {
        
        if Auth.auth().currentUser == nil {
        
        switch self {
            
            
        case .report: return "Report"
        case .termsOfUsage: return "Terms of Usage"
        case .termsOfPrivacy: return "Terms of Privacy"
        case .logout: return "Log In"
        }
        } else {
            
            
            switch self {
                
                
            case .report: return "Report"
            case .termsOfUsage: return "Terms of Usage"
            case .termsOfPrivacy: return "Terms of Privacy"
            case .logout: return "Log Out"
            }
            
        }
        
    }
}

//enum CommunicationOptions: Int, CaseIterable, SectionType {
//    case notifications
//    case email
//    case reportCrashes
//
//    var containsSwitch: Bool {
//        switch self {
//        case .notifications: return true
//        case .email: return true
//        case .reportCrashes: return true
//        }
//    }
//
//    var description: String {
//        switch self {
//        case .notifications: return "Notifications"
//        case .email: return "Email"
//        case .reportCrashes: return "Report Crashes"
//        }
//    }
//}

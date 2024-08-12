//
//  Config.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/31/24.
//

import Foundation

enum Config {
    
    static var openAiAPIKey: String {
        guard let key = Bundle.main.infoDictionary?["OPENAI_API_KEY"] as? String 
        else {
            assertionFailure("OPENAI_API_KEY could not found.")
            return ""
        }
        return key
    }
    
    static var wonyoungSystemContent: String {
        guard let content = Bundle.main.infoDictionary?["WONYOUNG_SYSTEM_CONTENT"] as? String
        else {
            assertionFailure("WONYOUNG_SYSTEM_CONTENT could not found.")
            return ""
        }
        return content
    }
    
    static var heejinSystemContent: String {
        guard let content = Bundle.main.infoDictionary?["HEEJIN_SYSTEM_CONTENT"] as? String
        else {
            assertionFailure("HEEJIN_SYSTEM_CONTENT could not found.")
            return ""
        }
        return content
    }
    
    static var wooheeSystemContent: String {
        guard let content = Bundle.main.infoDictionary?["WOOHEE_SYSTEM_CONTENT"] as? String
        else {
            assertionFailure("WOOHEE_SYSTEM_CONTENT could not found.")
            return ""
        }
        return content
    }
    
    static var heungminSystemContent: String {
        guard let content = Bundle.main.infoDictionary?["HEUNGMIN_SYSTEM_CONTENT"] as? String
        else {
            assertionFailure("HEUNGMIN_SYSTEM_CONTENT could not found.")
            return ""
        }
        return content
    }
}

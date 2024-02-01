//
//  Tab.swift
//  ScrollableTabView
//
//  Created by Ary Sugiarto on 30/01/24.
//

import SwiftUI

enum Tab : String, CaseIterable{
    case chats = "Chats"
    case calls = "Calls"
    case settings = "Settings"
    
    var systemImage: String{
        switch self{
            case .calls:
                return "phone"
            case .chats:
                return "bubble.left.and.text.bubble.right"
            case .settings:
                return "gear"
        }
    }
}

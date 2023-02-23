//
//  MacrosItemView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 23.02.23.
//

import SwiftUI

struct MacrosItemView: View {
    let macrosName: String
    let macrosValue: String
    
    var body: some View {
        VStack{
            Text(macrosName)
            Text(macrosValue)
        }
    }
}

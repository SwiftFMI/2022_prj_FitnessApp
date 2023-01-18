//
//  CloseModifier.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 14.01.23.
//

import SwiftUI

struct CloseModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content.toolbar {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
        }
    }
}

extension View {
    
    func addCloseButton() -> some View {
        self.modifier(CloseModifier())
    }
}

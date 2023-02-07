//
//  ButtonView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 10.01.23.
//

import SwiftUI

struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    private let cornerRadius: CGFloat = 10
    
    internal init(title: String,
                  background: Color = Colors.darkGrey,
                  foreground: Color = .white,
                  border: Color = .clear,
                  handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    var body: some View {
        Button(action: handler) {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
        .background(background)
        .foregroundColor(foreground)
        .font(.system(size: 18, weight: .semibold))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(border, lineWidth: 2)
        )
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ButtonView(title: "Primary Button") {}
            ButtonView(title: "Secondary Button", background: .clear, foreground: .green, border: .green) {}
        }
    }
}

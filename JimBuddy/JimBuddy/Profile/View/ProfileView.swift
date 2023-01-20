//
//  ProfileView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sessionService : SessionServiceImpl
    
    var body: some View {
        ButtonView(title: "Logout") {
            sessionService.logout()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImpl())
    }
}

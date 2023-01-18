//
//  HomePageView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 14.01.23.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var sessionService : SessionServiceImpl
    
    var body: some View {
        ButtonView(title: "Logout") {
            sessionService.logout()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(SessionServiceImpl())
    }
}

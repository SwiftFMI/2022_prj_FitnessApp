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
        TabView {
            DiaryView()
            .tabItem {
                Label("Diary",systemImage: "fork.knife")
            }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(SessionServiceImpl())
    }
}

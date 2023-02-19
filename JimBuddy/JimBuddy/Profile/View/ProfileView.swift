//
//  ProfileView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @State private var showGravatarInfoSheet = false
    @StateObject private var personalDataViewModel: PersonalDataViewModel = .init()

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                List {
                    ProfileDetailsView(gender: $personalDataViewModel.gender,
                                       firstName: $personalDataViewModel.firstName,
                                       lastName: $personalDataViewModel.lastName,
                                       image: $personalDataViewModel.userImage)
                        .listRowSeparator(.hidden)
                        .padding(.top, 40)
                        .gesture(TapGesture().onEnded { _ in
                            self.showGravatarInfoSheet.toggle()
                        })

                    HStack {
                        ProfileStatView(stat: .caloriesBurned, statValue: "1700")
                        Spacer()
                        ProfileStatView(stat: .exerciseTime, statValue: "3:34 h")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .listRowSeparator(.hidden)

                    HStack {
                        ProfileStatView(stat: .bodyWeight, statValue: "81 KG")
                        Spacer()
                        ProfileStatView(stat: .height, statValue: "185 cm")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .listRowSeparator(.hidden)

                    HStack {
                        ProfileStatView(stat: .moveDistance, statValue: "4.3 KM")
                        Spacer()
                        ProfileStatView(stat: .steps, statValue: "11435")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    CalendarView()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .tint(Colors.darkGrey)
                }
//                Button {
//                    sessionService.logout()
//                } label: {
//                    Image(systemName: "door.left.hand.open")
//                        .tint(.white)
//                }
            }
            .sheet(isPresented: $showGravatarInfoSheet) {
                GravatarInfoSheet(image: $personalDataViewModel.userImage)
            }
            .onAppear {
                personalDataViewModel.loadFullData()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImpl())
    }
}

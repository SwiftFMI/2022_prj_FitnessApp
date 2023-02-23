//
//  ProfileView.swift
//  JimBuddy
//
//  Created by Pavlin Dimitrov on 18.01.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @StateObject private var personalDataViewModel: PersonalDataViewModel = .init()
    @State private var showGravatarInfoSheet = false
    @State var showingEditScreen: Bool = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                List {
                    ProfileDetailsView(age: $personalDataViewModel.age,
                                       gender: $personalDataViewModel.gender,
                                       firstName: $personalDataViewModel.firstName,
                                       lastName: $personalDataViewModel.lastName,
                                       image: $personalDataViewModel.userImage)
                        .listRowSeparator(.hidden)
                        .padding(.top, 40)
                        .gesture(TapGesture().onEnded { _ in
                            self.showGravatarInfoSheet.toggle()
                        })

                    ForEach(0 ... personalDataViewModel.healthSamples.count / 2, id: \.self) { idx in
                        HStack {
                            if idx * 2 < personalDataViewModel.healthSamples.count {
                                ProfileStatView(stat: $personalDataViewModel.healthSamples[idx * 2].stat,
                                                statValue: $personalDataViewModel.healthSamples[idx * 2].value)
                                Spacer()
                            }

                            if idx * 2 + 1 < personalDataViewModel.healthSamples.count {
                                ProfileStatView(stat: $personalDataViewModel.healthSamples[idx * 2 + 1].stat,
                                                statValue: $personalDataViewModel.healthSamples[idx * 2 + 1].value)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    EditProfileView()
                        .environmentObject(sessionService)
                } label: {
                    Image(systemName: "square.and.pencil")
                        .tint(Colors.darkGrey)
                }
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

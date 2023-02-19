//
//  GravatarInfoSheet.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import Foundation
import SwiftUI

struct GravatarInfoSheet: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    Image("default_profile")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                    Spacer()
                }
                .shadow(radius: 15)
                .padding(.top, 20)
                .padding(.bottom, 20)
                .listRowSeparator(.hidden)

                HStack {
                    Spacer()
                    Text(Constants.header)
                        .font(.title)
                        .foregroundColor(Colors.darkGrey)
                        .multilineTextAlignment(.center)
                        .listRowSeparator(.hidden)
                        .padding(10)
                    Spacer()
                }

                Text(Constants.text1)
                    .foregroundColor(Colors.darkGrey)
                    .multilineTextAlignment(.center)
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                Text(Constants.text2)
                    .foregroundColor(Colors.darkGrey)
                    .multilineTextAlignment(.center)
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                HStack {
                    Spacer()
                    Link("Visit gravatar.com", destination: URL(string: "https://gravatar.com/")!)
                        .foregroundColor(Colors.green)
                    Spacer()
                }.listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .tint(Colors.darkGrey)
                    }
                }
            }
        }
    }

    private enum Constants {
        static let header: String = "Your image is powered by Gravatar"
        static let text1: String = """
        Integrated on millions of sites, Gravatar is a free service for site owners, developers, and anyone who wants an effortless and verified way to establish their identity online.
        """
        static let text2: String = """
        You can create a profile on Gravatar's website, upload an image and all sites that integrate it will get your new avatar automatically.
        """
    }
}

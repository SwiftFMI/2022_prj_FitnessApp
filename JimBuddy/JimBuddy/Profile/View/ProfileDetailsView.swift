//
//  ProfileImageView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import SwiftUI

struct ProfileDetailsView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    Image("default_profile")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())
                    ZStack {
                        Circle()
                            .fill(Colors.lightGrey)
                            .frame(width: 35, height: 35)
                        Image(systemName: "camera.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                }.shadow(radius: 20)

                Spacer()
            }
            Text("Simeon Hristov")
                .foregroundColor(Colors.darkGrey)
                .font(.title3)
                .padding(.top, 20)

            Text("simeon.hr01@gmail.com")
                .tint(Colors.lightGrey)
                .foregroundColor(Colors.lightGrey)
                .textCase(.uppercase)
                .font(.caption)

            Text("♂♀")
                .foregroundColor(Colors.darkGrey)
                .font(.title3)
        }
    }
}

struct ProfileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsView()
    }
}

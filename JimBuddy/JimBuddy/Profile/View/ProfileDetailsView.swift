//
//  ProfileImageView.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 19.02.23.
//

import SwiftUI

struct ProfileDetailsView: View {
    @Binding var gender: Gender?
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var image: UIImage

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: image)
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
            Text("\(firstName) \(lastName)")
                .foregroundColor(Colors.darkGrey)
                .font(.title3)
                .padding(.top, 20)

            Text("simeon.hr01@gmail.com")
                .tint(Colors.lightGrey)
                .foregroundColor(Colors.lightGrey)
                .textCase(.uppercase)
                .font(.caption)

            HStack(alignment: .center) {
                Text("21")
                    .foregroundColor(Colors.darkGrey)

                Image(gender?.iconName ?? "")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
            }
        }
    }
}

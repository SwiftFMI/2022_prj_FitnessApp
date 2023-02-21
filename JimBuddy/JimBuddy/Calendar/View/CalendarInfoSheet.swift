//
//  CalendarInfoSheet.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 21.02.23.
//
import Foundation
import SwiftUI

struct CalendarInfoSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()
                    Image("calendar")
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

                Text(Constants.text3)
                    .foregroundColor(Colors.darkGrey)
                    .multilineTextAlignment(.center)
                    .listRowSeparator(.hidden)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
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
        static let header: String = "Calendar feature"
        static let text1: String = """
        A way to keep in touch with your gym bros, allowing you to see whether they plan a workout in a specific day or no.
        """
        static let text2: String = """
        You can add your friends by entering their email in the field at the top of the screen and tapping 'Add friend'.
        """

        static let text3: String = """
        You can also confirm your workout by selecting a day and tapping 'Confirm workout'. Your friends can now see when you plan to workout.
        """
    }
}

struct CalendarInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        CalendarInfoSheet()
    }
}

//
//  NavigationConfiguration.swift
//  JimBuddy
//
//  Created by Simeon Hristov on 12.02.23.
//

import Foundation
import SwiftUI

struct NavigationConfiguration: UIViewControllerRepresentable {
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(Colors.green)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfiguration>
    ) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<NavigationConfiguration>) {}
}

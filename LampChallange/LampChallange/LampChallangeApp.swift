//
//  LampChallangeApp.swift
//  LampChallange
//
//  Created by dmikots on 08.01.2023.
//

import SwiftUI

@main
struct LampChallangeApp: App {
    @StateObject private var viewModel = LampViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

//
//  LampViewModel.swift
//  LampChallange
//
//  Created by dmikots on 08.01.2023.
//

import Foundation
import SwiftUI

class LampViewModel: ObservableObject {
    @Published var longText = ""
    @Published var isLampActive = false
    @Published var colorPicked = Color.white
    private(set) var defaultOffset: CGSize = .init(width: 0, height: 70)
    @Published var offset: CGSize
    init() {
        self.offset = defaultOffset
        loadData()
    }
    
    func changeOffset(_ size: CGSize) {
        offset = .init(width: size.width, height: size.height + 70)
    }
    
    func endDragLamp() {
        self.offset = defaultOffset
    }
    
    func activateDefaultSettings() {
        self.isLampActive = false
        self.colorPicked = .white
    }
    
     func activateLamp() {
        self.isLampActive = true
    }
    
   private func loadData() {
        if let filepath = Bundle.main.path(forResource: "longData", ofType: "txt") {
                    do {
                        let contents = try String(contentsOfFile: filepath)
                        DispatchQueue.main.async {
                            self.longText = contents
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                } else {
                    print("File not found")
                }
    }
}

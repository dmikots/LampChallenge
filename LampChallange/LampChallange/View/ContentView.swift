//
//  ContentView.swift
//  LampChallange
//
//  Created by dmikots on 08.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject  var viewModel: LampViewModel
    var body: some View {
        ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Text(viewModel.longText)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 80)
                }
                .zIndex(1)
            ColorPicker("", selection: $viewModel.colorPicked)
                .zIndex(2)
                .frame(
                    maxHeight: .infinity,
                    alignment: .top
                )
                .opacity(viewModel.isLampActive ? 0 : 1)
                .onChange(of: viewModel.colorPicked) { newValue in
                    if newValue != .white {
                        viewModel.activateLamp()
                    }
                }
            //lightbulb
            ZStack(alignment: .top) {
                Wire(lightbulbOffset: viewModel.offset)
                        .stroke(
                            Color(.gray),
                        lineWidth: 4)
                        Image(systemName: "lightbulb.led.fill")
                            .resizable()
                            .frame(width: 30, height: 50)
                            .foregroundColor(viewModel.colorPicked)
                            .rotationEffect(.degrees(180))
                            .overlay(
                        Circle()
                            .fill(viewModel.colorPicked)
                            .frame(width: 200, height: 200)
                            .opacity(0.5)
                            .blur(radius: 40)
                            .opacity(viewModel.isLampActive ? 1 : 0)
                        )
                            .offset(viewModel.offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                viewModel.changeOffset(gesture.translation)
                            }
                            .onEnded { _ in
                                viewModel.endDragLamp()
                            }
                    )
                    .onTapGesture {
                        viewModel.activateDefaultSettings()
                    }
                
            }
            .zIndex(3)
            .animation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.35,
                    blendDuration: 0
                ),
                value: viewModel.offset == viewModel.defaultOffset
            )
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

struct Wire: Shape {
    var lightbulbOffset: CGSize
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: 0))
            path.addLine(to: .init(x: lightbulbOffset.width + rect.midX, y: lightbulbOffset.height))
        }
    }
    //big thx Alex Kraev for this knowledge :)
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(lightbulbOffset.width, lightbulbOffset.height) }
        set {
            lightbulbOffset.width = newValue.first
            lightbulbOffset.height = newValue.second
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}

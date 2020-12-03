//
//  ContentView.swift
//  Wave
//
//  Created by Patrick Maltagliati on 11/12/20.
//

import SwiftUI

struct ContentView: View {
    @State private var percent: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(range, id: \.self) { index in
                    Wave(percent: percent, length: geo.frame(in: .global).width / CGFloat(range.count))
                        .fill(colors[index] ?? .gray)
                        .offset(x: geo.frame(in: .global).width / CGFloat(range.count) * CGFloat(index),
                                y: geo.frame(in: .global).height / 2)
                        .animation(Animation.linear.speed(0.1).repeatForever(autoreverses: true))
                        .onAppear {
                            percent = 1
                        }
                }
            }
        }
    }

    var range: Range<Int> {
        -5..<6
    }

    var colors: [Int: Color] {
        [
            -4: Color.blue,
            -3: Color.green,
            -2: Color.yellow,
            -1: Color.orange,
            0: Color.red,
            1: Color.orange,
            2: Color.yellow,
            3: Color.green,
            4: Color.blue
        ]
    }
}

struct Wave: Shape {
    var percent: CGFloat
    let length: CGFloat

    var animatableData: CGFloat {
        get { percent }
        set { percent = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start: CGFloat = (rect.maxX - length) * percent
        let end = start + length
        path.move(to: CGPoint(x: start, y: 0))
        path.addCurve(to: CGPoint(x: end, y: 0),
                      control1: CGPoint(x: (end + start) / 2, y: rect.midY),
                      control2: CGPoint(x: (end + start) / 2, y: -rect.midY))
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

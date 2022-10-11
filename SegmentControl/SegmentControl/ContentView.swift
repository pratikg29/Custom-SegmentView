//
//  ContentView.swift
//  SegmentControl
//
//  Created by Pratik on 03/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedSegment1: Segment = .morning
    @State private var selectedSegment2: Segment = .morning
    @State var animation: Animation = .default
    @State var themeColor: Color = .primary
    @State var cornerRadius: CGFloat = 10
    @State var selectedAnimationIndex: Int = 0
    
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 100) {
                VStack(spacing: 20) {
                    SegmentControlView(segments: Segment.allCases,
                                       selected: $selectedSegment1,
                                       titleNormalColor: themeColor,
                                       titleSelectedColor: .white,
                                       bgColor: themeColor,
                                       animation: animation) { segment in
                        Text(segment.title)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    } background: {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    }
                    .frame(height: 37)
                    
                    SegmentControlView(segments: Segment.allCases,
                                       selected: $selectedSegment2,
                                       titleNormalColor: themeColor,
                                       titleSelectedColor: .white,
                                       bgColor: themeColor,
                                       animation: animation) { segment in
                        Image(systemName: segment.icon)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    } background: {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    }
                    .frame(height: 37)
                }
                .padding()
                .background(Color.white.cornerRadius(20))
                
                VStack(spacing: 20) {
                    Slider(value: $cornerRadius, in: 0...20) {
                        Text("Corner Radius")
                    } onEditingChanged: { changed in
                        
                    }
                    
                    Picker("Animation", selection: $selectedAnimationIndex) {
                        Text("Default").tag(0)
                        Text("Spring").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedAnimationIndex) { newValue in
                        switch newValue {
                        case 0:
                            animation = .default
                        case 1:
                            animation = .spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)
                        default:
                            animation = .default
                        }
                    }
                    
                    ColorPicker(selection: $themeColor) {
                        Text("Theme")
                            .bold()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 50)
            .padding(.horizontal)
        }
        .background(Color.init(white: 0.95))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

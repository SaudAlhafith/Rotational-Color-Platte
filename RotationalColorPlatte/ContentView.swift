//
//  ContentView.swift
//  RotationalColorPlatte
//
//  Created by saudAlhafith on 21/06/1445 AH.
//

import SwiftUI

struct ContentView: View {
    let size: CGFloat
    @State var currentColor: Color = .red
    @State var showPlatte: Bool = false
    let platteColors: [Color] = [.red, .pink, .purple, .blue, .cyan, .green, .yellow, .orange] // you can add as many colors as you want
    @State var rotation: CGFloat = 0
    
    init(size: CGFloat = 300) {
        self.size = size // also you can control the size
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: showPlatte ? size : size * 0.5)
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .overlay {
                        Circle()
                            .fill(currentColor)
                            .frame(width: size / 3)
                            .shadow(color: .black.opacity(0.4), radius: 6)
                    }
                    .onTapGesture {
                        withAnimation{
                            showPlatte.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                            withAnimation{
                                rotation = 360
                            }
                        }
                    }
                    .zIndex(1)
                
                
                ZStack{
                    if showPlatte {
                        ForEach(0..<(platteColors.count), id: \.self) { index in
                            let indexcg = CGFloat(index)
                            let order: CGFloat = showPlatte ? indexcg : CGFloat(platteColors.count - 1 - index)
                            Capsule()
                                .fill(platteColors[index])
                                .frame(width: (size / 3 * 1.4 / 2), height: (size / 3 * 1.4))
                                .offset(y: -(size / 3 * 1.4 / 2))
                                .rotationEffect(Angle(degrees: indexcg * (rotation / CGFloat(platteColors.count))), anchor: .center)
                                .shadow(color: .black.opacity(0.5), radius: 6)
                                .transition(.scale.animation(Animation.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 1.5).delay(order * 0.04)))
                                .onTapGesture {
                                    withAnimation {
                                        rotation = 0
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
                                        withAnimation {
                                            currentColor = platteColors[index]
                                            showPlatte.toggle()
                                        }
                                    }
                                }
                                .zIndex(Double(index) + 2)
                            
                        }
                        
                    }
                }
                .id(showPlatte)
                .transition(.opacity.animation(Animation.easeInOut(duration: 0.2).delay(0.1)))
                .zIndex(2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Rectangle()
                .fill(currentColor.gradient.opacity(0.6))
        }
        .ignoresSafeArea()
    }
}


#Preview {
    ContentView()
}

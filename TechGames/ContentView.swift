//
//  ContentView.swift
//  TechGames
//
//  Created by Çağatay Yıldız on 4.09.2024.
//
import SwiftUI

struct ContentView: View {
    
    @State var point : Int = 0
    
    var colors: [Color] = [.red, .green, .yellow, .orange, .blue, .black]
    @State var focusColor: Color = .black
    
    var colorsText: [String] = ["Red", "Green", "Yellow", "Orange", "Blue", "Black"]
    @State var focusColorText: String = ""
    
    var body: some View {
        VStack{
            
            Text(String(point))
                .font(.largeTitle)
                .padding()
            
            Divider()
            
            Text(focusColorText)
                .font(.largeTitle)
                .padding()
                .foregroundColor(focusColor)
            
            HStack{
                Button("True") {
                    if checkColorMatch() {
                        point = point + 5
                    } else {
                        point = point - 10
                    }
                    
                    selectNewColor()
                }
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
                
                Button("False") {
                    if !checkColorMatch() {
                        point = point + 5
                    } else {
                        point = point - 10
                    }
                    
                    selectNewColor()
                }
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
            }
        
        }
        .onAppear() {
            // Random olarak colors dizisinden bir eleman seçeceğim
            selectNewColor()
        }
    }
    
    // Renk ve metni kontrol eden yardımcı fonksiyon
    func checkColorMatch() -> Bool {
        // Text ile Color'ı karşılaştırmak için metni ve rengi eşleştiriyoruz
        switch focusColorText {
        case "Red":
            return focusColor == .red
        case "Green":
            return focusColor == .green
        case "Yellow":
            return focusColor == .yellow
        case "Orange":
            return focusColor == .orange
        case "Blue":
            return focusColor == .blue
        case "Black":
            return focusColor == .black
        default:
            return false
        }
    }
    
    func selectNewColor() {
            if let randomColor = colors.randomElement() {
                focusColor = randomColor
            }
            
            if let randomfocusColorText = colorsText.randomElement() {
                focusColorText = randomfocusColorText
            }
        }
}

#Preview {
    ContentView()
}

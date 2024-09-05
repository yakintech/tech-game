//
//  ContentView.swift
//  TechGames
//
//  Created by Çağatay Yıldız on 4.09.2024.
//
import SwiftUI

struct ContentView: View {
    
    @State var maxScore : Int = 0
    @State var totalGames : Int = 0
    @State var point : Int = 0
    @State var timer: Timer?

    
    var colors: [Color] = [.red, .green, .yellow, .blue]
    @State var focusColor: Color = .black
    
    var colorsText: [String] = ["Red", "Green", "Yellow", "Blue"]
    @State var focusColorText: String = ""

    
    var body: some View {
        VStack{
            
            Button("Reset Game Data"){
                UserDefaults.standard.removeObject(forKey: "totalGames")
                UserDefaults.standard.removeObject(forKey: "max")
                totalGames = 0
                maxScore = 0
            }
            
            Text("Total Games: \(totalGames)")
                .padding()
            
            Text("Max Score: \(maxScore)")
                .padding()
                .font(.title)
            
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
                        
                        if(point > maxScore){
                            maxScore = point
                            UserDefaults.standard.set(maxScore, forKey: "max")
                        }
                        
                    } else {
                        point = 0
                        totalGames = totalGames + 1
                        UserDefaults.standard.set(totalGames, forKey: "totalGames")
                    }
                    resetTimer()
                    selectNewColor()
                    
                }
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
                
                Button("False") {
                    if !checkColorMatch() {
                        point = point + 5
                        
                        if(point > maxScore){
                            maxScore = point
                            UserDefaults.standard.set(maxScore, forKey: "max")
                        }
                        
                    } else {
                        point = 0
                        totalGames = totalGames + 1
                        UserDefaults.standard.set(totalGames, forKey: "totalGames")
                    }
                    resetTimer()
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
            maxScore = UserDefaults.standard.integer(forKey: "max")
            totalGames = UserDefaults.standard.integer(forKey: "totalGames")

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
        startTimer()
        }
    func startTimer() {
        timer?.invalidate() // mevcut zamanlayıcı varsa durdur
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            // 2 saniye içinde butona tıklanmazsa puanı sıfırla
            point = 0
            totalGames += 1
            UserDefaults.standard.set(totalGames, forKey: "totalGames")
            selectNewColor()
        }
    }

    func resetTimer() {
        timer?.invalidate() // zmanlayıcıyı sıfırla
        startTimer() //yeni zamanlayıcı başlat
    }

}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  TechGames
//
//  Created by Çağatay Yıldız on 4.09.2024.
//
import SwiftUI

struct ContentView: View {
    
    @State var maxScore: Int = 0
    @State var totalGames: Int = 0
    @State var point: Int = 0
    @State var timer: Timer?
    
    var colors: [Color] = [.red, .green, .yellow, .blue]
    @State var focusColor: Color = .black
    
    var colorsText: [String] = ["Red", "Green", "Yellow", "Blue"]
    @State var focusColorText: String = ""
    
    // Animasyon için gerekli state
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            // Animasyonlu arka plan - Pastel renkler
            LinearGradient(gradient: Gradient(colors: animateGradient ? [Color(red: 0.7, green: 0.9, blue: 1.0), Color(red: 0.9, green: 1.0, blue: 0.8), Color(red: 1.0, green: 0.9, blue: 0.9)] : [Color(red: 1.0, green: 0.8, blue: 0.7), Color(red: 0.9, green: 0.8, blue: 0.6), Color(red: 0.8, green: 0.9, blue: 1.0)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true)) // Daha uzun ve yumuşak geçiş
                .onAppear {
                    animateGradient.toggle()
                }
            
            VStack(spacing: 20) {
                // Başlık
                Text("Color Matching Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7)) // Sabit arka plan boyutu
                    .cornerRadius(8)
                    .padding(.top, 50)
                
                Spacer()
                
                // Oyun bilgileri
                HStack {
                    VStack {
                        Text("Total Games")
                            .font(.subheadline)
                        Text("\(totalGames)")
                            .font(.title2)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Max Score")
                            .font(.subheadline)
                        Text("\(maxScore)")
                            .font(.title2)
                            .bold()
                    }
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(8) // Daha küçük bir köşe yuvarlama
                .padding(.horizontal)
                
                // Skor
                Text("Score: \(point)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8) // Sabit arka plan ve köşe yuvarlama
                
                Spacer()
                
                // Renk ismi
                Text(focusColorText)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(focusColor)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(8) // Sabit arka plan ve köşe yuvarlama
                
                Spacer()
                
                // Düğmeler
                HStack(spacing: 30) {
                    Button(action: {
                        handleButtonAction(isTrue: true)
                    }) {
                        Text("True")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8) // Daha düz kenarlar
                            .shadow(radius: 3)
                    }
                    
                    Button(action: {
                        handleButtonAction(isTrue: false)
                    }) {
                        Text("False")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8) // Daha düz kenarlar
                            .shadow(radius: 3)
                    }
                }
                
                Spacer()
                
                // Oyun sıfırlama düğmesi
                Button(action: resetGameData) {
                    Text("Reset Game Data")
                        .font(.subheadline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8) // Sabit boyut ve düz kenar
                        .shadow(radius: 3)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            selectNewColor()
            maxScore = UserDefaults.standard.integer(forKey: "max")
            totalGames = UserDefaults.standard.integer(forKey: "totalGames")
        }
    }
    
    func handleButtonAction(isTrue: Bool) {
        if (isTrue && checkColorMatch()) || (!isTrue && !checkColorMatch()) {
            point += 5
            if point > maxScore {
                maxScore = point
                UserDefaults.standard.set(maxScore, forKey: "max")
            }
        } else {
            point = 0
            totalGames += 1
            UserDefaults.standard.set(totalGames, forKey: "totalGames")
        }
        resetTimer()
        selectNewColor()
    }
    
    func checkColorMatch() -> Bool {
        switch focusColorText {
        case "Red": return focusColor == .red
        case "Green": return focusColor == .green
        case "Yellow": return focusColor == .yellow
        case "Blue": return focusColor == .blue
        default: return false
        }
    }
    
    func selectNewColor() {
        focusColor = colors.randomElement() ?? .black
        focusColorText = colorsText.randomElement() ?? ""
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            point = 0
            totalGames += 1
            UserDefaults.standard.set(totalGames, forKey: "totalGames")
            selectNewColor()
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        startTimer()
    }
    
    func resetGameData() {
        UserDefaults.standard.removeObject(forKey: "totalGames")
        UserDefaults.standard.removeObject(forKey: "max")
        totalGames = 0
        maxScore = 0
    }
}

#Preview {
    ContentView()
}

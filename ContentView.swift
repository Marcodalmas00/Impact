import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            SideMenuView()
                .navigationTitle("Impact")
        }
    }
}

struct SideMenuView: View {
    @State private var selectedOption: String? = "ImpactNow"
    
    var body: some View {
        List(selection: $selectedOption) {
            NavigationLink(destination: Home(), tag: "ImpactNow", selection: $selectedOption) {
                Label {
                    Text("Impact now")
                } icon: {
                    Image(systemName: "globe.europe.africa.fill")
                        .foregroundColor(.blue)
                }
            }
            
            NavigationLink(destination: CO2Calculator(), tag: "CO2Calculator", selection: $selectedOption) {
                Label {
                    Text("CO2 Calculator")
                } icon: {
                    Image(systemName: "tree")
                        .foregroundColor(.green)
                }
            }
            
            NavigationLink(destination: WaterCalculator(), tag: "WaterCalculator", selection: $selectedOption) {
                Label {
                    Text("Water Calculator")
                } icon: {
                    Image(systemName: "drop")
                        .foregroundColor(.cyan)
                }
            }
            
            NavigationLink(destination: ElectricityCalculator(), tag: "ElectricityCalculator", selection: $selectedOption) {
                Label {
                    Text("Electricity Calculator")
                } icon: {
                    Image(systemName: "bolt")
                        .foregroundColor(.yellow)
                }
            }
            
            NavigationLink(destination: Quiz(), tag: "Quiz", selection: $selectedOption) {
                Label {
                    Text("Quiz")
                } icon: {
                    Image(systemName: "checkmark.message")
                        .foregroundColor(.red)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .background(Color.clear)
    }
}

struct Home: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemBlue).opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("IMPACT")
                        .font(.system(size: 64, weight: .bold))
                        .padding(.bottom, 40)
                    
                    Text("#MakeAChangeBeTheChange")
                        .font(.system(size: 32, weight: .bold))
                        .padding(.bottom, 40)
                    
                    Text("Welcome to Impact, your tool to uncover the environmental effects of your choices. Learn how everyday actions shape our planet's health. Explore the impact you make and join us in making informed, eco-conscious decisions for a more sustainable future.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Text("Select a topic:")
                        .font(.subheadline)
                        .padding()
                    
                    VStack(spacing: 20) {
                        NavigationLink(destination: CO2_1()) {
                            ButtonView(label: "CO2 🌳", color: .blue, textColor: colorScheme == .dark ? .white : .black)
                        }
                        
                        NavigationLink(destination: WATER_1()) {
                            ButtonView(label: "Water 💧", color: .blue, textColor: colorScheme == .dark ? .white : .black)
                        }
                        
                        NavigationLink(destination: ELEC_1()) {
                            ButtonView(label: "Electricity ⚡️", color: .blue, textColor: colorScheme == .dark ? .white : .black)
                        }
                        
                    }
                }
                .padding(.bottom, 50)
                .padding(.top, 20)
            }
        }
    }
}


struct ButtonView: View {
    var label: String
    var color: Color
    var textColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 200, height: 50)
                .overlay(
                    Text(label)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(textColor)
                )
        }
        .padding(.bottom, 20)
    }
}




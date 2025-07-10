import SwiftUI

struct CO2_1: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemGreen).opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 10) {
                    Text("CO2")
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.1))
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text("what is it?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Text("CO2, or carbon dioxide, is a vital gas in Earth's atmosphere, crucial for regulating the planet's temperature within a range suitable for life. While CO2 levels have fluctuated throughout Earth's history due  to various natural processes such as volcanic eruptions, respiration by plants and animals, and oceanic absorption, human activities have significantly increased them, leading to concerns about climate change. Indeed, when there's too much CO2, it traps heat from the sun, causing the Earth's temperature to rise and resulting in climate-related disasters like hurricanes, floods, and droughts. Excessive CO2 emissions disrupt the planet's delicate balance and have devastating effects on the environment and society.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("To help reduce CO2 emissions, you can make simple changes in your daily life. Turn off lights when you leave a room, walk, bike, or take public transport instead of driving alone, and use energy-efficient appliances. Plant trees in your community, recycle, and support renewable energy sources like solar and wind power. Every small action adds up to make a big difference in reducing CO2 emissions and protecting our planet.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    HStack {
                        NavigationLink(destination: CO2Calculator()) {
                            ButtonView(label: "Calculator", color: .blue, textColor: colorScheme == .dark ? .white : .black)
                        }
                        .padding()
                        NavigationLink(destination: Quiz()) {
                            ButtonView(label: "Quiz", color: .blue, textColor: colorScheme == .dark ? .white : .black)
                        }
                        .padding()
                    }
                    
                }
                .padding()
            }
        }
    }
}

struct CO2Calculator: View {
    @State private var inputNumber: Double = 0
    @State private var isHybridCar: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemGreen).opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("🚘 CO2 Calculator")
                    .font(.title)
                
                Text("On average, a car produces \(isHybridCar ? 110 : 140) g/km of CO2, but this number can double in older car types.")
                    .font(.body)
                    .padding()
                
                HStack {
                    Text("How many km do you travel in a year:")
                        .font(.body)
                    
                    TextField("Enter a number", value: $inputNumber, format: .number)
                        .keyboardType(.numberPad)
                        .padding(.all)
                        .border(Color(UIColor.separator))
                }
                .padding(.horizontal)
                
                Toggle("Hybrid Car", isOn: $isHybridCar)
                    .padding()
                
                let co2Kg = (inputNumber * (isHybridCar ? 110 : 140)) / 1000
                Text("\(String(co2Kg)) Kg of CO2")
                    .font(.title2)
                    .padding()
                
                Text("The average full-grown 🌳 will absorb 21 kg of CO2 every year, so you will need:")
                    .font(.body)
                    .padding()
                
                let treesNeeded = co2Kg / 21
                Text("\(String(Int(treesNeeded))) trees")
                    .font(.title2)
                
                Text(comparisonText(for: Int(treesNeeded)))
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func comparisonText(for trees: Int) -> String {
        switch trees {
        case 1..<15:
            return "This amount of trees could fit in your house garden."
        case 15..<26:
            return "This amount of trees could fit in a tennis court."
        case 26..<42:
            return "This is equivalent to half a basketball court."
        case 42..<280:
            return "This covers more than a basketball court but less than an Olympic pool."
        case 280..<320:
            return "This is equivalent to an Olympic pool."
        case 320..<535:
            return "We are close to a football field."
        case 535..<714:
            return "This is around a football field."
        case 714..<800:
            return "This is between a soccer field and a baseball field."
        case 800...:
            return "This exceeds the size of a baseball field."
        default:
            return "An unexpected number of trees."
        }
    }
}
    
struct CO2CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CO2Calculator()
    }
}


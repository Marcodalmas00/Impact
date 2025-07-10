import SwiftUI

struct WATER_1: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemCyan).opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 10) {
                    Text("WATER")
                        .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.1))
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text("what is it?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Text("Water, the elixir of life, is vital for all ecosystems and forms of life, human existence included. Even if Earth, affectionately known as the 'blue planet,' is blessed with abundant water, only 2.5% of this water is freshwater. This scarcity of freshwater, exacerbated by pollution and climate change, presents pressing global challenges, posing thus a serious threat to Earth as a whole. Urgent action is indeed necessary for sustainable water management to safeguard the health and vitality of every organism present in the environment.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("Individuals play a crucial role in addressing water scarcity and ensuring sustainable water management. Practicing responsible water use is imperative, starting with simple actions like fixing leaks, using water-efficient appliances, and adopting mindful habits at home. Conserving water not only helps protect ecosystems and sustain agriculture but also combats climate change. Additionally, supporting policies and initiatives that promote water conservation and advocating for responsible water management practices can make a significant difference. By collectively embracing these actions, individuals contribute to preserving this precious resource for a sustainable and positive future.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    HStack {
                        NavigationLink(destination: WaterCalculator()) {
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

struct WaterCalculator: View {
    @State private var showerFrequency: Double = 0.0
    @State private var bathFrequency: Double = 0.0
    @State private var laundryFrequency: Double = 0.0
    @State private var dishwasherFrequency: Double = 0.0
    @State private var isHighEfficiencyShower: Bool = false
    @State private var isHighEfficiencyDishwasher: Bool = false
    @State private var plantWatering: Double = 0.0
    @State private var plantSize: PlantSize = .medium
    @State private var isSwimmingPoolOn: Bool = false
    
    enum PlantSize: String, CaseIterable {
        case small = "Small"
        case medium = "Medium"
        case big = "Big"
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemCyan).opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("💧 Water Calculator")
                    .font(.title)
                
                HStack {
                    Text("Showers per Week:")
                    Slider(value: $showerFrequency, in: 0...14, step: 1.0)
                    Text("\(Int(showerFrequency))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Baths per Week:")
                    Slider(value: $bathFrequency, in: 0...7, step: 1.0)
                    Text("\(Int(bathFrequency))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Laundry per Week:")
                    Slider(value: $laundryFrequency, in: 0...14, step: 1.0)
                    Text("\(Int(laundryFrequency))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Dishwasher per Week:")
                    Slider(value: $dishwasherFrequency, in: 0...14, step: 1.0)
                    Text("\(Int(dishwasherFrequency))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("High Efficiency Shower Heads:")
                    Toggle("", isOn: $isHighEfficiencyShower)
                    Text(isHighEfficiencyShower ? "On" : "Off")
                }
                .padding()
                
                HStack {
                    Text("High Efficiency Dishwasher:")
                    Toggle("", isOn: $isHighEfficiencyDishwasher)
                    Text(isHighEfficiencyDishwasher ? "On" : "Off")
                }
                .padding()
                
                HStack {
                    Text("Garden Size:")
                    Picker("Plant Size", selection: $plantSize) {
                        ForEach(PlantSize.allCases, id: \.self) { size in
                            Text(size.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Plant Watering per Week:")
                    Slider(value: $plantWatering, in: 0...20, step: 1.0)
                    Text("\(Int(plantWatering))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Swimming Pool:")
                    Toggle("", isOn: $isSwimmingPoolOn)
                    Text(isSwimmingPoolOn ? "On" : "Off")
                }
                .padding()
                
                Text("Total Water Usage: \(calculateWaterUsage()) liters")
                    .font(.body)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
    
    func calculateWaterUsage() -> Int {
        var showerLiters: Double = 38.0
        var bathLiters: Double = 75.0
        var laundryLiters: Double = 50.0
        var dishwasherLiters: Double = 15.0
        var plantLiters: Double = 5.0
        var poolLiters: Double = 1000.0
        var base: Double = 40
        
        if isHighEfficiencyShower {
            showerLiters -= 10.0
        }
        
        if isHighEfficiencyDishwasher {
            laundryLiters -= 5.0
            dishwasherLiters -= 5.0
        }
        
        switch plantSize {
        case .small:
            plantLiters = 15.0
        case .medium:
            plantLiters = 35.0
        case .big:
            plantLiters = 80.0
        }
        
        var totalWaterUsage = (showerFrequency * showerLiters) + (bathFrequency * bathLiters) + (laundryFrequency * laundryLiters) + (dishwasherFrequency * dishwasherLiters) + (plantWatering * plantLiters) + (isSwimmingPoolOn ? poolLiters : 0) + base
        
        return Int(totalWaterUsage)
    }
}

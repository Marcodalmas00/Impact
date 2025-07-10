import SwiftUI

struct ELEC_1: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemYellow).opacity(0.2))
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
                    
                    Text("Electricity, the lifeblood of modern society, powers our homes, industries, and technology. It illuminates our lives, fuels our appliances, and drives progress. However, our reliance on electricity comes with challenges. While it provides convenience and efficiency, the generation and consumption of electricity often have environmental consequences. From burning fossil fuels to nuclear power, our current methods of electricity production contribute to air and water pollution, habitat destruction, and climate change. As our demand for electricity continues to grow, finding sustainable solutions becomes increasingly urgent.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Text("To address the challenges associated with electricity production and consumption, individuals can take proactive steps to reduce their environmental impact. Embracing energy-efficient practices at home and in the workplace, such as using LED light bulbs, turning off appliances when not in use, and investing in energy-efficient appliances, can significantly reduce electricity consumption. Supporting renewable energy sources like solar and wind power, advocating for policies that prioritize clean energy, and participating in community initiatives for energy conservation can also make a difference. By banding together to adopt these measures, individuals can pave the way for a more sustainable and robust energy future in the time to come.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    HStack {
                        NavigationLink(destination: ElectricityCalculator()) {
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


struct ElectricityCalculator: View {
    @State private var selectedLightbulbs: Int = 0
    @State private var selectedLightbulbsString: String = ""
    @State private var selectedTVs: Int = 0
    @State private var selectedScreenString: String = ""
    @State private var isLEDEnabled: Bool = false
    @State private var isEfficientAppliancesEnabled: Bool = false
    @State private var laundryPerWeek: Double = 0
    @State private var useDryer: Bool = false
    @State private var dishwasherPerDay: Double = 0
    @State private var ovenUsagePerWeek: Double = 0
    @State private var AC: Bool = false
    @State private var heatPump: Bool = false
    
    let lightbulbOptions = Array(0...10)
    let tvOptions = Array(0...5)
    
    @State private var currentStep: Int = 1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemYellow).opacity(0.2))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Text("⚡️ Eelectricity Calculator")
                        .font(.title)
                    switch currentStep {
                    case 1:
                        Step1()
                    case 2:
                        Step2()
                    case 3:
                        Step3()
                    default:
                        Step1()
                    }
                    
                    HStack {
                        if currentStep > 1 {
                            backButton
                        }
                        
                        Spacer()
                        
                        if currentStep < 3 {
                            nextButton
                        }
                    }
                    .padding()
                }
                
                ResultView(calculateElectricityUsage: calculateElectricityUsage())
                    .padding()
            }
            .padding()
        }
    }
    
    private var backButton: some View {
        Button(action: {
            withAnimation {
                currentStep -= 1
            }
        }) {
            Text("Back")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 100)
                .background((Color.orange).opacity(0.8))
                .cornerRadius(10)
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            withAnimation {
                currentStep += 1
            }
        }) {
            Text("Next")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 100)
                .background((Color.red).opacity(0.8))
                .cornerRadius(10)
        }
    }

    func Step1() -> some View {
        VStack {
            Text("Step 1: Select TV and Lights")
                .font(.title)
                .padding()
            
            HStack {
                Text("Number of Lightbulbs:")
                Spacer()
                TextField("", text: $selectedScreenString)
                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(selectedScreenString.publisher.collect()) {
                        self.selectedScreenString = String($0.prefix(3))
                        if let value = Int(selectedScreenString) {
                            self.selectedTVs = value
                        }
                    }
            }
            .padding(.horizontal)

            
            HStack {
                Text("Number of Tvs or Screen:")
                Spacer()
                TextField("", text: $selectedLightbulbsString)
                    .keyboardType(.numberPad)
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onReceive(selectedLightbulbsString.publisher.collect()) {
                        self.selectedLightbulbsString = String($0.prefix(3))
                        if let value = Int(selectedLightbulbsString) {
                            self.selectedLightbulbs = value
                        }
                    }
            }
            .padding(.horizontal)
            
            HStack {
                Text("LED Lights:")
                Spacer()
                Toggle("", isOn: $isLEDEnabled)
            }
            .padding()
            
            Spacer()
        }
    }
    
    func Step2() -> some View {
        VStack {
            Text("Step 2: Select Washer and Dishwasher")
                .font(.title)
                .padding()
            
            HStack {
                Text("Laundry per Week:")
                Spacer()
                Slider(value: $laundryPerWeek, in: 0...14, step: 1)
                    .padding(.horizontal)
                Text("\(Int(laundryPerWeek)) loads")
            }
            .padding()
            
            HStack {
                Text("Use Dryer:")
                Spacer()
                Toggle("", isOn: $useDryer)
            }
            .padding()
            
            HStack {
                Text("Dishwasher per Week:")
                Spacer()
                Slider(value: $dishwasherPerDay, in: 0...21, step: 1)
                    .padding(.horizontal)
                Text("\(Int(dishwasherPerDay)) times")
            }
            .padding()
            
            Spacer()
        }
    }
    
    func Step3() -> some View {
        VStack {
            Text("Step 3: Additional Appliances")
                .font(.title)
                .padding()
            
            HStack {
                Text("Oven Usage per Week:")
                Spacer()
                Slider(value: $ovenUsagePerWeek, in: 0...14, step: 1)
                    .padding(.horizontal)
                Text("\(Int(ovenUsagePerWeek)) times")
            }
            .padding()
            
            HStack {
                Text("Efficient Appliances:")
                Spacer()
                Toggle("", isOn: $isEfficientAppliancesEnabled)
            }
            .padding()
            
            HStack {
                Text("AC:")
                Spacer()
                Toggle("", isOn: $AC)
            }
            .padding()
            
            HStack {
                Text("Heat pump:")
                Spacer()
                Toggle("", isOn: $heatPump)
            }
            .padding()
            
            Spacer()
        }
    }
    
    func ResultView(calculateElectricityUsage: Int) -> some View {
        VStack {
            Text("Electricity Usage Summary")
                .font(.title)
                .padding()
            
            Text("Total Electricity Usage: \(calculateElectricityUsage) kWh a week")
                .font(.body)
                .padding(.horizontal)
            
            Spacer()
        }
    }
    
    func calculateElectricityUsage() -> Int {
        let lundaryTime: Double = 1.0
        var lundaryAvgWattH: Int = 1000
        let dryerTime: Double = 0.75
        var dryerAvgWattH: Int = 4000
        let dishwasherTime: Double = 2.0
        var dishwasherAvgWattH: Int = 1200
        let ovenTime: Double = 1.0
        var ovenAvgWattH: Int = 2500
        let ACTime: Double = 6.0
        var ACAvgWattH: Int = 1500
        let heatpumpTime: Double = 8.0
        var heatpumpAvgWattH = 1500
        var lightbulbPower: Int = 60
        let lightbulbTime: Double = 10.0
        let tvTime: Double = 8.0
        let tvAvgWattH: Int = 100
        
        if isLEDEnabled {
            lightbulbPower = 10
        }
        if isEfficientAppliancesEnabled {
            lundaryAvgWattH = 700
            dryerAvgWattH = 3000
            dishwasherAvgWattH = 800
            ovenAvgWattH = 1800
            ACAvgWattH = 1200
            heatpumpAvgWattH = 1000
        }
        
        var totalElectricityUsage = isEfficientAppliancesEnabled ? 5.0 * 7 : 6.0 * 7
        totalElectricityUsage += Double(selectedLightbulbs) * lightbulbTime * Double(lightbulbPower) / 1000
        
        totalElectricityUsage += laundryPerWeek * lundaryTime * Double(lundaryAvgWattH) / 1000
        totalElectricityUsage += useDryer ? laundryPerWeek * dryerTime * Double(dryerAvgWattH) / 1000 : 0
        totalElectricityUsage += dishwasherPerDay * dishwasherTime * Double(dishwasherAvgWattH) / 1000
        totalElectricityUsage += ovenUsagePerWeek * ovenTime * Double(ovenAvgWattH) / 1000
        
        if AC {
            totalElectricityUsage += ACTime * Double(ACAvgWattH) / 1000
        }
        
        if heatPump {
            totalElectricityUsage += heatpumpTime * Double(heatpumpAvgWattH) / 1000
        }
        
        totalElectricityUsage += Double(selectedTVs) * tvTime * Double(tvAvgWattH) / 1000
        
        return Int(totalElectricityUsage)
    }
}

import SwiftUI

struct CalculatorView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var transportationMiles: String = ""
    @State private var electricityUsage: String = ""
    @State private var meatConsumption: String = ""
    @State private var flightsPerYear: String = ""
    
    @State private var carbonFootprintResult: String = "Enter your data to see the carbon footprint."
    @State private var isResultVisible: Bool = false
    @FocusState private var isKeyboardFocused: Bool
    
    let carbonFootprintFactors: [String: Double] = [
        "Transportation": 0.411,
        "Electricity": 0.92,
        "Meat Consumption": 27.0,
        "Flights": 250.0
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                inputFields
                calculateButton
                Spacer()
                if isResultVisible {
                   footer
                }
                Spacer()
            }
            .padding()
            .focused($isKeyboardFocused)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Carbon Footprint Calculator")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        })
        .onTapGesture {
            isKeyboardFocused = false
        }
    }
    
    private var inputFields: some View {
        VStack {
            inputField(title: "Miles driven per week", value: $transportationMiles)
            inputField(title: "Electricity usage per month (kWh)", value: $electricityUsage)
            inputField(title: "Kilograms of meat eaten per week", value: $meatConsumption)
            inputField(title: "Flights taken per year", value: $flightsPerYear)
        }
    }
    
    private var calculateButton: some View {
        Button(action: {
            calculateCarbonFootprint()
            isKeyboardFocused = false
        }) {
            Text("Calculate Footprint")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.cyan.opacity(0.5))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.top)
    }
    
    private var footer: some View {
        VStack {
            Text("Total Carbon Footprint: \(carbonFootprintResult) kg CO2")
                .font(.title2)
                .padding(.top, 20)
                .foregroundColor(.green)
            
            Text("Carbon Footprint Level: \(carbonFootprintLevel())")
                .font(.headline)
                .padding(.top, 5)
                .foregroundColor(.orange)
        }
    }
    
    private func inputField(title: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            TextField("Enter value", text: value)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isKeyboardFocused)
        }
        .padding(.bottom, 10)
    }
    
    private func calculateCarbonFootprint() {
        let transportation = (Double(transportationMiles) ?? 0) * carbonFootprintFactors["Transportation"]! * 52
        let electricity = (Double(electricityUsage) ?? 0) * carbonFootprintFactors["Electricity"]! * 12
        let meat = (Double(meatConsumption) ?? 0) * carbonFootprintFactors["Meat Consumption"]! * 52
        let flights = (Double(flightsPerYear) ?? 0) * carbonFootprintFactors["Flights"]!
        
        let totalFootprint = transportation + electricity + meat + flights
        carbonFootprintResult = String(format: "%.2f", totalFootprint)
        isResultVisible = true
    }
    
    private func carbonFootprintLevel() -> String {
        guard let total = Double(carbonFootprintResult) else { return "Unknown" }
        
        switch total {
        case ..<5000:
            return "Low 🌱"
        case 5000..<15000:
            return "Medium 🌎"
        default:
            return "High 🔥"
        }
    }
}

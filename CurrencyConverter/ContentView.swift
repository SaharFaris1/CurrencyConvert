

import SwiftUI

struct ContentView: View {

        
        @State private var itemSelected = 0
        @State private var itemSelected2 = 1
        @State private var amount : String = ""
        private let currencies = ["SR", "USD", "EUR"]
        
        func convert(_ convert: String) -> String{
            var conversion: Double = 0.1
            let amount = Double(convert.doubleValue)
            let selectedCurrency = currencies[itemSelected]
            let to = currencies[itemSelected2]
            let srRates = ["SR": 1.0, "USD": 0.27, "EUR": 0.25]
            let usdRates = ["SR": 3.75, "USD": 1.0, "EUR": 0.92]
            let eurRates = ["SR": 4.07, "USD": 1.085, "EUR": 1.0]
            
            
            switch(selectedCurrency){
            case "SR" :
                conversion = amount * (srRates[to] ?? 0.0)
            case "USD" :
                conversion = amount * (usdRates[to] ?? 0.0)
            case "EUR" :
                conversion = amount * (eurRates[to] ?? 0.0)
            default:
                print("Something went wrong!")
            }
            
            return String(format: "%.2f", conversion)
        }
        var body: some View {
            ZStack{
                NavigationView{
                    VStack{
                        Form {
                            Section(header: Text("Convert a currency").foregroundColor(.black).font(.title3).bold()) {
                                TextField("Enter an amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                
                                Picker(selection: $itemSelected, label: Text("From")) {
                                    ForEach(0..<currencies.count) { index in
                                        Text(self.currencies[index]).tag(index)
                                    }
                                }
                                Picker(selection: $itemSelected2, label: Text("To")) {
                                    ForEach(0..<currencies.count) { index in
                                        Text(self.currencies[index]).tag(index)
                                    }
                                }
                            }
                            Section(header: Text("Conversion").foregroundColor(.black).font(.title3).bold()){
                                Text("\(convert(amount)) \(currencies[itemSelected2])")
                                
                            }
                        }
                    }
                }
            }}
    }
#Preview {
    ContentView()
}

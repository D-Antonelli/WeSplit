//
//  ContentView.swift
//  WeSplit
//
//  Created by Derya Antonelli on 14/01/2022.
//

import SwiftUI

struct ContentView: View {
    private let tipPercentages = [10, 15, 20, 25, 0]
    private let currencyFormat = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
                Form {
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                            
                    }
                    
                    Section {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                    
                    Section {
                        Text(grandTotal, format: currencyFormat)
                    } header: {
                        Text("Grand total")
                    }
                    
                    Section {
                        Text(totalPerPerson, format: currencyFormat)
                    } header: {
                        Text("Amount per person")
                    }
                   
                }.navigationTitle("We Split")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Done") {
                            Spacer()
                            amountIsFocused = false
                        }
                    }
                }
                }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}

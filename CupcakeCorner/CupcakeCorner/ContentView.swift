//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinklers", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    let addressView = AddressView(order: order)
                    NavigationLink("Delivery details") {
                        addressView.onAppear(perform: {
                            addressView.fetchSavedValues()
                        })
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

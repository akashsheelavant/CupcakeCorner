//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 7/28/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                        .onAppear(perform: {
                            saveOrder()
                        })
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func saveOrder() {
        do {
            if let encoded = try? JSONEncoder().encode(order) {
                UserDefaults.standard.setValue(encoded, forKey: "order")
            }
        }
    }
    
    func fetchSavedValues() {
        if let orderData = UserDefaults.standard.value(forKey: "order") as? Data {
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: orderData) {
                order.name = decodedOrder.name
                order.streetAddress = decodedOrder.streetAddress
                order.city = decodedOrder.city
                order.zip = decodedOrder.zip
            }
        }                
    }        
}

#Preview {
    AddressView(order: Order())
}

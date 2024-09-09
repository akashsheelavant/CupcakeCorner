//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 8/4/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmationMessage = false
    
    @State private var errorMessage = ""
    @State private var showingErrorMessage = false
    
    
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format:.currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                    
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmationMessage, actions: {
            Button("OK", action: {})
        }, message: {
            Text(confirmationMessage)
        })
        .alert("Error!", isPresented: $showingErrorMessage, actions: {
            Button("OK", action: {})
        }, message: {
            Text(errorMessage)
        })
        .scrollBounceBehavior(.automatic)
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodeOrder.quantity)x \(Order.types[decodeOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmationMessage = true
        } catch {
            errorMessage = error.localizedDescription
            showingErrorMessage = true
            print("Checkout failed: \(error.localizedDescription)")
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}

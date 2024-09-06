//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Akash Sheelavant on 8/4/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
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
                    // button action
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.automatic)
    }
}

#Preview {
    CheckoutView(order: Order())
}

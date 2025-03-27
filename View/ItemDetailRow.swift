//
//  ItemDetailRow.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 24/2/25.
//

import SwiftUI

struct ItemDetailRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(width: 150, alignment: .leading)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 5)
    }
}

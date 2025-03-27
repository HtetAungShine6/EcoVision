//
//  ResultView.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 26/1/25.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var detectionResult: String
    var capturedImage: UIImage?
    @State private var alternativeItem: Items?
    @State private var isFlipped = false
    
    var body: some View {
        VStack {
            detectedImage
            if let item = Items.allItems.first(where: { $0.name == detectionResult }) {
                itemDetails(for: item)
            }
            Spacer()
            buttons
        }
        .navigationBarBackButtonHidden()
    }
    
    private var detectedImage: some View {
        VStack {
            if let uiImage = capturedImage {
                ZStack(alignment: .bottomLeading) {
                    if let item = Items.allItems.first(where: { $0.name == detectionResult }) {
                        if isFlipped {
                            Image("\(item.suggestionImageName)")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .clipped()
                                .shadow(radius: 5)
                                .transition(.asymmetric(insertion: .opacity.combined(with: .scale), removal: .opacity))
                        } else {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .cornerRadius(30)
                                .clipped()
                                .shadow(radius: 5)
                                .transition(.asymmetric(insertion: .opacity.combined(with: .scale), removal: .opacity))
                        }
                        
                        HStack {
                            Text(detectionResult)
                                .font(.callout)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                                .padding(.horizontal, 10)
                            Spacer()
                            Text("\(isFlipped ? item.alternativeLevel : item.level)")
                                .font(.callout)
                                .foregroundColor(colorForLevel(level: isFlipped ? item.alternativeLevel : item.level))
                                .shadow(radius: 5)
                                .padding(.horizontal, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                    }
                }
                .animation(.easeInOut(duration: 0.5), value: isFlipped)
                .shadow(radius: 20)
            } else {
                Text("No Image Available")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func itemDetails(for item: Items) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            ItemDetailRow(title: "👣 Footprint", value: isFlipped ? item.suggestionFootprint : item.footprint)
                .transition(.opacity.combined(with: .move(edge: .leading)))
            ItemDetailRow(title: "🤔 Suggestion", value: item.suggestion)
                .transition(.opacity.combined(with: .move(edge: .leading)))
            ItemDetailRow(title: "🌍 Global Production", value: isFlipped ? item.suggestionGlobalProductionPerDay : item.globalProductionPerDay)
                .transition(.opacity.combined(with: .move(edge: .leading)))
            ItemDetailRow(title: "⚙️ Suggested Item", value: item.suggestionItemName)
                .transition(.opacity.combined(with: .move(edge: .leading)))
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
    
    private var buttons: some View {
        HStack {
            Button(action: {
                navigationManager.pop()
            }) {
                Text("Go Back")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: 180)
                    .background(Color.cyan.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
            }
            Spacer()
            Button(action: {
                isFlipped.toggle()
            }) {
                Text(isFlipped ? "See Original" : "See Alternative")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: 180)
                    .background(Color.cyan.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func colorForLevel(level: Items.FootprintLevel) -> Color {
        switch level {
        case .veryLow:
            return Color.green
        case .low:
            return Color.green
        case .medium:
            return Color.yellow
        case .high:
            return Color.red
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

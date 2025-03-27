//
//  Items.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 26/1/25.
//

struct Items {
    let name: String
    let footprint: String
    let suggestion: String
    let suggestionFootprint: String
    let suggestionImageName: String
    let suggestionItemName: String
    let level: FootprintLevel
    let alternativeLevel: FootprintLevel
    let globalProductionPerDay: String
    let suggestionGlobalProductionPerDay: String
    
    enum FootprintLevel {
        case veryLow
        case low
        case medium
        case high
    }
    
    static let allItems: [Items] = [
        Items(
            name: "Plastic Bag",
            footprint: "0.1 kg CO₂e",
            suggestion: "Reusable Cloth Bag",
            suggestionFootprint: "0.03 kg CO₂e",
            suggestionImageName: "ReusableClothBag",
            suggestionItemName: "Reusable Cloth Bag",
            level: .medium,
            alternativeLevel: .veryLow,
            globalProductionPerDay: "60,000 tons",
            suggestionGlobalProductionPerDay: "3,000 tons"
        ),
        Items(
            name: "Plastic Water Bottle",
            footprint: "0.15 kg CO₂e",
            suggestion: "Stainless Steel Water Bottle",
            suggestionFootprint: "0.04 kg CO₂e",
            suggestionImageName: "StainlessSteelWaterBottle",
            suggestionItemName: "Stainless Steel Water Bottle",
            level: .high,
            alternativeLevel: .low,
            globalProductionPerDay: "15,000 tons",
            suggestionGlobalProductionPerDay: "1,500 tons"
        ),
        Items(
            name: "Plastic Cup",
            footprint: "0.08 kg CO₂e",
            suggestion: "Reusable Cup",
            suggestionFootprint: "0.02 kg CO₂e",
            suggestionImageName: "ReusableCup",
            suggestionItemName: "Reusable Cup",
            level: .medium,
            alternativeLevel: .low,
            globalProductionPerDay: "10,000 tons",
            suggestionGlobalProductionPerDay: "2,000 tons"
        )
    ]
}


//1.    United Nations Environment Programme (UNEP):
//•    UNEP provides comprehensive reports and data on global environmental issues, including plastic pollution.
//•    Website: https://www.unep.org
//2.    Our World in Data:
//•    This platform offers extensive data on various global challenges, including plastic production, waste, and associated greenhouse gas emissions.
//•    Website: https://ourworldindata.org
//3.    Plastic Footprint Calculator by Omni Calculator:
//•    This tool helps estimate the environmental impact of various plastic items, providing insights into their decomposition times and carbon footprints.
//•    Website: https://www.omnicalculator.com/ecology/plastic-footprint
//4.    “Plastic bags and plastic bottles – CO2 emissions during their lifetime” by Time for Change:
//•    This article discusses the carbon footprint associated with the production and disposal of plastic bags and bottles.
//•    Website: https://timeforchange.org/plastic-bags-and-plastic-bottles-co2-emissions-during-their-lifetime/
//5.    “The impact of plastic packaging on life cycle energy consumption and greenhouse gas emissions in Europe” by Denkstatt:
//•    This study analyzes the greenhouse gas emissions associated with plastic packaging and offers insights into its environmental impact.
//•    Website: https://plasticseurope.org/wp-content/uploads/2021/10/2011-Denkstatt-Summary-E-GHG_Packaging.pdf
//6.    “Plastic Pollution” by Our World in Data:
//•    This resource provides data and visualizations on plastic production, waste generation, and environmental impacts.
//•    Website: https://ourworldindata.org/plastic-pollution
//7.    “Greenhouse gas emissions from plastics” by Our World in Data:
//•    This article delves into the greenhouse gas emissions throughout the lifecycle of plastics.
//•    Website: https://ourworldindata.org/grapher/greenhouse-gas-emissions-from-plastics

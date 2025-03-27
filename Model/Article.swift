struct Article: Codable, Equatable, Hashable {
    let name: String
    let image: String
    let subtitle: String
    let paragraph: String
}

let mockArticles: [Article] = [
    Article(
        name: "The Impact of Plastic Waste",
        image: "plastic_waste", 
        subtitle: "How plastic pollution affects our environment",
        paragraph: "Plastic waste is a major environmental issue, polluting oceans and harming wildlife. Every year, millions of tons of plastic end up in landfills and water bodies, taking hundreds of years to decompose. Reducing plastic use and recycling can significantly reduce environmental damage."
    ),
    Article(
        name: "Sustainable Energy Sources",
        image: "sustainable_energy",
        subtitle: "Exploring renewable energy solutions",
        paragraph: "Renewable energy sources like solar, wind, and hydro power are essential for a sustainable future. Unlike fossil fuels, these energy sources produce minimal carbon emissions and help combat climate change. Investing in clean energy solutions is key to reducing our carbon footprint."
    ),
    Article(
        name: "The Benefits of a Plant-Based Diet",
        image: "plant_based_diet",
        subtitle: "How reducing meat consumption helps the planet",
        paragraph: "Switching to a plant-based diet can reduce greenhouse gas emissions, save water, and decrease deforestation. The meat industry is one of the largest contributors to carbon emissions. By eating more plant-based foods, we can promote a healthier environment and lifestyle."
    ),
    Article(
        name: "Eco-Friendly Transportation",
        image: "eco_transport",
        subtitle: "Reducing carbon footprint with green transport",
        paragraph: "Using bicycles, electric vehicles, and public transport can significantly reduce carbon emissions. The transportation sector is a major contributor to pollution, and choosing sustainable alternatives can help improve air quality and fight climate change."
    ),
    Article(
        name: "Reducing Household Energy Consumption",
        image: "energy_saving",
        subtitle: "Simple ways to cut down on energy use",
        paragraph: "Small changes like using LED bulbs, unplugging devices, and investing in energy-efficient appliances can lower electricity consumption. Reducing energy use not only saves money but also decreases carbon emissions, benefiting both individuals and the planet."
    )
]

//
//  ContentView.swift
//  RecipeBook
//
//  Created by Abhimanyu Dev Gupta on 01/07/2024.
//

import SwiftUI

//Declare a model for each dessert, 'let' used instead of 'var' to create immutable objects
struct Dessert: Codable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

//Declare a model for details for each specific dessert, like name, ingredients and measurements
struct DessertDetails: Codable{
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strIngredient7: String
    let strIngredient8: String
    let strIngredient9: String
    let strIngredient10: String
    let strIngredient11: String
    let strIngredient12: String
    let strIngredient13: String
    let strIngredient14: String
    let strIngredient15: String
    let strIngredient16: String
    let strIngredient17: String
    let strIngredient18: String
    let strIngredient19: String
    let strIngredient20: String
    let strMeasure1: String
    let strMeasure2: String
    let strMeasure3: String
    let strMeasure4: String
    let strMeasure5: String
    let strMeasure6: String
    let strMeasure7: String
    let strMeasure8: String
    let strMeasure9: String
    let strMeasure10: String
    let strMeasure11: String
    let strMeasure12: String
    let strMeasure13: String
    let strMeasure14: String
    let strMeasure15: String
    let strMeasure16: String
    let strMeasure17: String
    let strMeasure18: String
    let strMeasure19: String
    let strMeasure20: String
}

struct ContentView: View {
    @State private var desserts = [Dessert]()  //List of desserts
    
    var body: some View { //Desserts presented in NavigationView,
        NavigationView {  //Consists of desserts sorted alphabetically
            List(desserts.sorted(by: {$0.strMeal < $1.strMeal}), id:\.idMeal){ dessert in
                VStack(alignment: .leading) {
                    Text(dessert.strMeal).font(.body) //Vertical arrangement of dessert followed by image
                    AsyncImage(
                        url: URL(string: dessert.strMealThumb),
                        content: { image in
                            image.resizable()
                                .frame(maxWidth: 150, maxHeight: 150)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    NavigationLink(destination:DetailsView(dessert: dessert)){
                        Text("Learn more about the recipe")
                            .foregroundColor(.blue)
                    } //Adds a link under each recipe to go to the details view
                }
            }
            .navigationTitle("Desserts")  //Giving the page a title
            .task {
                await fetchDessert() //Wait until the fetchDessert() method gets basic info for all desserts
            }
        }
    }
    
    func fetchDessert() async {  //Method to fetch dessert information from API
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Meals.self,from: data)
            
            let filtered = response.meals.filter {dessert in
                !dessert.strMeal.isEmpty && !dessert.strMealThumb.isEmpty && !dessert.idMeal.isEmpty
            }  //Filter out the null values
            
            DispatchQueue.main.async {   //Update the desserts list
                desserts = filtered
            }
        } catch {
            print("Could not find desserts")   //Error message in case link is faulty or other issues arise
        }
    }
}

struct DetailsView: View {  //View for a specific recipe, takes the dessert as an argument
    @State private var details: DessertDetails? //Details for specific dessert, as received by fetchDessertDetails function
    
    let dessert: Dessert   //The dessert for which we want to get details.
    var body: some View {
        NavigationView {
            ScrollView {  //More suitable for pages with long text
                if let details = details {    //Make sure 'details' isn't empty
                    VStack(alignment: .leading) {  //Layout for details
                        Text(details.strMeal).font(.headline)
                        Spacer()  //To add space between variables
                        Text(details.strInstructions).font(.body)
                        Spacer()
                        Text("\(details.strIngredient1) : \(details.strMeasure1)")
                        Text("\(details.strIngredient2) : \(details.strMeasure2)")
                        Text("\(details.strIngredient3) : \(details.strMeasure3)")
                        Text("\(details.strIngredient4) : \(details.strMeasure4)")
                        Text("\(details.strIngredient5) : \(details.strMeasure5)")
                        Text("\(details.strIngredient6) : \(details.strMeasure6)")
                        Text("\(details.strIngredient7) : \(details.strMeasure7)")
                        Text("\(details.strIngredient8) : \(details.strMeasure8)")
                        Text("\(details.strIngredient9) : \(details.strMeasure9)")
                        Text("\(details.strIngredient10) : \(details.strMeasure10)")
                        Text("\(details.strIngredient11) : \(details.strMeasure11)")
                        Text("\(details.strIngredient12) : \(details.strMeasure12)")
                        Text("\(details.strIngredient13) : \(details.strMeasure13)")
                        Text("\(details.strIngredient14) : \(details.strMeasure14)")
                        Text("\(details.strIngredient15) : \(details.strMeasure15)")
                        Text("\(details.strIngredient16) : \(details.strMeasure16)")
                        Text("\(details.strIngredient17) : \(details.strMeasure17)")
                        Text("\(details.strIngredient18) : \(details.strMeasure18)")
                        Text("\(details.strIngredient19) : \(details.strMeasure19)")
                        Text("\(details.strIngredient20) : \(details.strMeasure20)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    ProgressView() //Loading indicator if details is empty
                }
            }

        }
        .task {
            await fetchDessertDetails(dessert: dessert)  //Only proceed with the rest of the view after fetching a dessert's details
        }
    }
    
    func fetchDessertDetails(dessert: Dessert) async {  //Function to fetch each individual dessert's details
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(dessert.idMeal)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(MealDetails.self,from: data)
            
            DispatchQueue.main.async {
                details = response.meals.first   //Obtain details from the response
            }
        } catch {
            print("Could not find information about this dessert")   //Error message in case link is faulty or other issues arise
        }
    }
}

struct Meals: Codable {
    let meals: [Dessert]
}  //All dessert information is contained in the meals array, so this step is important to access the names, images and id of each dessert

struct MealDetails: Codable {
    let meals: [DessertDetails]
}  //All dessert information is contained in the meals array, so this step is important to access the details for each dessert

#Preview {
    ContentView()
}

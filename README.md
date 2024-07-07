# RecipeBook
This is my submission for the Fetch iOS Coding Challenge. 

### Overview
My code makes a simple application that presents a list of desserts from an API(https://themealdb.com/api/json/v1/1/filter.php?c=Dessert) with images for each one. It allows users to click on each dessert and view details about it, and navigate back to the full list of desserts. 

### General Structure
I created two models, one for the list of desserts and another for each desserts specific information. The fetchDessert() function leverages the "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert" endpoint to get a list of desserts, while the fetchDessertDetails() function uses the "https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID" endpoint to get information about a particular dessert, identified by the unique identifier MEAL_ID. I also use two views, one to show the list of desserts, and DetailsView to show a user the details for a specific dessert. I have left comments throughout my code for guidance. 

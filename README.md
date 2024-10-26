
# NutriPair

## Purpose of the Project

NutriPair is a mobile application designed to assist users in
identifying and creating balanced meals by suggesting food combinations based on nutritional data. 
It allows users to input dietary preferences and restrictions,
plan meals, and visually build meals using a drag-and-drop interface. 
This app aims to make meal planning easier and more personalized for users with various dietary needs.

## Features

- **Dietary Preferences and Restrictions:** Users can input specific dietary preferences (e.g., vegan, keto, gluten-free) and restrictions.
- **Meal Planning Assistant:** AI-driven meal planner that learns user preferences over time and suggests weekly meal plans.
- **Visual Meal Builder:** Drag-and-drop interface for creating meals visually with immediate feedback on nutritional values.
- **Downloadable Meal Plans:** Users can download meal plans and grocery lists for offline access.

## Setup and Running the Application Locally

To set up and run the NutriPair application locally, follow these steps:

1. **Clone the Repository:**


   git clone https://github.com/ndush/nutripair.git
   cd nutripair
Install Dependencies:

Make sure you have Node.js and npm installed. Then run:


npm install
or if you're using Yarn:


yarn install
Start the Development Server:


npm start
Your application should now be running at http://localhost:3000.

Basic Usage Instructions
Open the application in your browser or mobile simulator.
Navigate to the preferences section to input your dietary restrictions and preferences.
Use the meal planning assistant to receive suggestions based on your preferences.
Explore the visual meal builder to create custom meals.
Download meal plans and grocery lists for offline access.
API Integration
NutriPair utilizes the Spoonacular API to fetch nutritional data and meal suggestions. To integrate the Spoonacular API:

Sign Up for an API Key:

Create an account on Spoonacular and obtain your API key.
Add the API Key to Your Project:

Store your API key in a .env file or directly in your code (make sure not to expose it in public repositories).
Example usage in code:
javascript
Copy code
const API_KEY = process.env.SPOONACULAR_API_KEY;
const response = await fetch(`https://api.spoonacular.com/recipes/complexSearch?apiKey=${API_KEY}&diet=vegan`);
Contributing
Contributions are welcome! If you would like to contribute to NutriPair, please follow these guidelines:

Fork the Repository: Click on the "Fork" button in the top right corner of the repository page.

Create a Feature Branch:


git checkout -b feature/YourFeatureName
Make Your Changes: Implement the desired changes or features.

Commit Your Changes:


git commit -m "Add your message about the changes"
Push to the Branch:


git push origin feature/YourFeatureName
Open a Pull Request: Go to the original repository and click on "New Pull Request."

Thank you for considering contributing to NutriPair!

License
This project is licensed under the MIT License - see the LICENSE file for details.









# Install and load required libraries
# install.packages("shiny")
library(shiny)
library(randomForest)

data <- read.csv("Customer_data.csv")

grocery_items <- c("Milk", "Bread", "Apples", "Bananas", "Cereal", "Coffee", "Juice", "Yogurt", "Cheese", "Pasta", "Ice Cream", "Tomatoes", "Oranges", "Chicken", "Potatoes", "Carrots", "Salmon", "Water", "Lettuce", "Frozen Pizza", "Rice", "Beans", "Peanut Butter", "Chocolate", "Chips", "Soda", "Tea", "Soup", "Bottled Water", "Crackers", "Cookies", "Canned Soup", "Spaghetti Sauce", "Pickles", "Salsa", "Tortilla Chips", "Ice Cream", "Eggs", "Salami", "Onions", "Mustard", "Mayonnaise", "Bread", "Ketchup", "Hot Dogs", "Sausages", "Steak", "Bacon", "Ham", "Turkey", "Lamb", "Beef", "Shrimp", "Crab", "Lobster", "Clams", "Mussels", "Sardines", "Tuna", "Cod", "Trout", "Haddock", "Halibut", "Catfish", "Bass", "Pickerel", "Pike", "Walleye", "Smelt", "Squid", "Grouper", "Mahi Mahi", "Tilapia", "Pork Chops", "Hamburger Patties", "Swordfish", "Salmon", "Trout", "Haddock", "Halibut", "Catfish", "Bass", "Pickerel", "Pike", "Walleye", "Smelt", "Squid", "Grouper", "Mahi Mahi", "Tilapia", "Pork Chops", "Hamburger Patties", "Swordfish", "Salmon", "Trout", "Haddock", "Halibut", "Catfish", "Bass", "Pickerel", "Pike", "Walleye", "Smelt", "Squid", "Grouper", "Mahi Mahi", "Tilapia", "Pork Chops", "Hamburger Patties", "Swordfish", "Salmon", "Trout", "Haddock", "Halibut", "Catfish", "Bass", "Pickerel", "Pike", "Walleye", "Smelt", "Squid", "Grouper", "Mahi Mahi", "Tilapia", "Pork Chops", "Hamburger Patties", "Swordfish", "Salmon", "Trout", "Haddock", "Halibut", "Catfish", "Bass", "Pickerel", "Pike", "Walleye", "Smelt", "Squid", "Grouper", "Mahi Mahi", "Tilapia", "Pork Chops", "Hamburger Patties", "Swordfish")

# Train a Random Forest model
set.seed(123) 
model <- randomForest(Fraud ~ ., data = data)

# Define UI for application
ui <- fluidPage(
  titlePanel("Customer Fraud Detection Mechanism"),
  
  
  sidebarLayout(
    sidebarPanel(
      
      textInput("customer_name", "Customer Name", ""),
      textInput("item_bought", "Item Bought", ""),
      numericInput("interest_measure", "Interest Measure", value = 0, min = 0, max = 100),
      actionButton("predict_button", "Predict")
    ),
    
    mainPanel(
      
      textOutput("prediction_text")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  observeEvent(input$predict_button, {
    new_data <- data.frame(
      CustomerName = input$customer_name,
      CommodityBought = input$item_bought,
      InterestMeasure = input$interest_measure
    )
    
    prediction <- predict(model, new_data)
    
    if (toupper(new_data$CommodityBought) %in% toupper(grocery_items)) {
      output$prediction_text <- renderText({
        if (prediction == "1") {
          "Likely raudulent transaction"
        } else {
          "Customer is not Fraud"
        }
      })
    } else {
      output$prediction_text <- renderText("Fraudulent transaction (Non-grocery item)")
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)

# Customer Fraud Detection Mechanism

## Overview
This Project can be used to find fraudulant customers at a grocery store.
It is a Shiny web application designed to detect potential fraudulent transactions based on customer data. The core of the project utilizes a Random Forest model to predict whether a transaction is likely to be fraudulent or not, based on the input features provided by the user.

## Features

- **Customer Name**: Enter the name of the customer.
- **Item Bought**: Enter the name of the item purchased.
- **Interest Measure**: Enter a numerical value representing an interest measure whether the customer is likely to visit the store again or not(0-100).

## How It Works

1. **Data Input**: Users provide the customer name, the item bought, and an interest measure through the web interface.
2. **Prediction**: When the "Predict" button is clicked, the application checks if the item bought is a grocery item (from a predefined list). 
   - If the item is a grocery item, it uses the trained Random Forest model to predict whether the transaction is fraudulent.
   - If the item is not a grocery item, it automatically flags the transaction as fraudulent.
3. **Output**: The application displays whether the transaction is likely to be fraudulent or not based on the model's prediction and the item category check.

## Installation

To run this application locally, you need to have R and the required packages installed.

### Required Libraries

- `shiny`
- `randomForest`

### Installation Steps

1. Install the required R packages:
    ```R
    install.packages("shiny")
    install.packages("randomForest")
    ```

2. Load the required libraries in your R script:
    ```R
    library(shiny)
    library(randomForest)
    ```

3. Load the customer data:
    ```R
    data <- read.csv("Customer_data.csv")
    ```

## Random Forest Approach

Random Forest is an ensemble learning method for classification, regression, and other tasks that operates by constructing a multitude of decision trees during training. The output of the Random Forest is the mode of the classes (classification) or mean prediction (regression) of the individual trees.

### Why Random Forest?

- **Robustness**: It reduces overfitting by averaging multiple decision trees, which makes it robust to noise in the dataset.
- **Accuracy**: It generally provides high accuracy predictions.
- **Feature Importance**: It can be used to determine the importance of each feature in the prediction process.

### Training the Model

The Random Forest model is trained using the customer data (`Customer_data.csv`). The `Fraud` column is used as the response variable, and the rest of the columns are used as predictors.

```R
set.seed(123) 
model <- randomForest(Fraud ~ ., data = data)
```

## Running the Application

1. Define the UI of the application using `fluidPage`, `sidebarLayout`, `sidebarPanel`, and `mainPanel`.
2. Implement the server logic to handle input events and perform predictions.
3. Run the Shiny application.

```R
shinyApp(ui = ui, server = server)
```

## File Structure

- `app.R`: Contains the Shiny app code, including UI definition and server logic.
- `Customer_data.csv`: The dataset used for training the Random Forest model.

## Usage

1. Run the Shiny application by sourcing the `app.R` file or by running the script in RStudio.
2. Enter the required information (customer name, item bought, interest measure) in the input fields.
3. Click on the "Predict" button to get the prediction result.

## Conclusion

This Shiny application provides a simple yet effective way to predict fraudulent transactions based on customer data using a Random Forest model. It showcases the integration of machine learning models into web applications, enabling real-time predictions and user interaction.
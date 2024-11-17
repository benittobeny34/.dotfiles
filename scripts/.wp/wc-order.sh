#!/usr/bin/env bash

# Ensure wp-cli is available
command -v wp >/dev/null 2>&1 || { echo >&2 "wp-cli is not installed. Aborting."; exit 1; }

# Select products interactively using fzf
echo "Fetching product list..."
product_list=$(wp wc product list --allow-root --user=benittobeny34@gmail.com --fields=id,name,price,type --format=csv | tail -n +2)

if [ -z "$product_list" ]; then
  echo "No products found. Exiting."
  exit 1
fi

# Show product list with fzf for multiple selection
selected_products=$(echo "$product_list" | awk -F ',' '{print $1" - "$2" - "$3" - "$4}' | fzf -m --prompt="Select products:")

if [ -z "$selected_products" ]; then
  echo "No products selected. Exiting."
  exit 1
fi

# Prompt for customer details with default values for state, country, city, and shipping address
read -p "First Name: " first_name
read -p "Last Name: " last_name
read -p "Billing Email: " billing_email
read -p "Shipping Address (Line 1, default: 2/10): " shipping_address_1
shipping_address_1=${shipping_address_1:-"2/10"}  # Default to "2/10" if no input is provided
read -p "Shipping Address (Line 2, default: Karur): " shipping_address_2
shipping_address_2=${shipping_address_2:-"Karur"}  # Default to "Karur" if no input is provided
read -p "City (default: P.Udayapatti): " city
city=${city:-"P.Udayapatti"}  # Default to "P.Udayapatti" if no input is provided
read -p "State (default: TN): " state
state=${state:-TN}  # Default to "TN" if no input is provided
read -p "Postcode (default: 639119): " postcode
postcode=${postcode:-639119}  # Default to "639119" if no input is provided
read -p "Country (default: IN): " country
country=${country:-IN}  # Default to "IN" if no input is provided
read -p "Payment Method (default: cod): " payment_method
payment_method=${payment_method:-cod}  # Default to "cod" if no input is provided

# Define available order statuses
order_statuses=("on-hold" "pending" "processing" "completed" "cancelled" "refunded" "failed" "checkout-draft")

# Show available order statuses and allow user to select one
selected_status=$(echo "${order_statuses[@]}" | tr ' ' '\n' | fzf --prompt="Select order status:")

# If no selection is made, default to "on-hold"
selected_status=${selected_status:-"on-hold"}

# Initialize an empty array to store line items
line_items=()

# Loop through the selected products and get the product ID, price, and type
IFS=$'\n'
for product in $selected_products; do
  product_id=$(echo "$product" | awk -F ' - ' '{print $1}')
  product_name=$(echo "$product" | awk -F ' - ' '{print $2}')
  product_price=$(echo "$product" | awk -F ' - ' '{print $3}')
  product_type=$(echo "$product" | awk -F ' - ' '{print $4}')
  
  # Allow user to input quantity for each product
  read -p "Enter quantity for '$product_name' (Price: $product_price, Type: $product_type): " quantity
  quantity=${quantity:-1} # Default to 1 if no input is provided
  
  # Build the line_items JSON object for each product
  line_items+=("{\"product_id\":$product_id,\"quantity\":$quantity}")
done

# Join the line items array into a single string, separating by commas
line_items_json=$(IFS=,; echo "[${line_items[*]}]")

# Create a table for displaying order details
echo -e "\nOrder Summary"
echo -e "--------------------------------------------"
echo -e "First Name:  $first_name"
echo -e "Last Name:   $last_name"
echo -e "Email:       $billing_email"
echo -e "Shipping Address: $shipping_address_1, $shipping_address_2"
echo -e "City:        $city"
echo -e "State:       $state"
echo -e "Postcode:    $postcode"
echo -e "Country:     $country"
echo -e "Payment Method: $payment_method"
echo -e "Order Status: $selected_status"
echo -e "\nProducts Selected:"
echo -e "--------------------------------------------"
echo -e "ID   Product Name             Quantity"
echo -e "--------------------------------------------"

# Debug: Show the line items to check the structure
echo -e "\nLine Items JSON: $line_items_json"

# Create the order command
order_create_command="wp wc shop_order create --allow-root --user=benittobeny34@gmail.com \
  --status=$selected_status \
  --customer_note='Created via script' \
  --billing='{\"first_name\":\"$first_name\",\"last_name\":\"$last_name\",\"email\":\"$billing_email\",\"address_1\":\"$shipping_address_1\",\"address_2\":\"$shipping_address_2\",\"city\":\"$city\",\"state\":\"$state\",\"postcode\":\"$postcode\",\"country\":\"$country\"}' \
  --payment_method=$payment_method \
  --line_items='$line_items_json'"

# Execute the order creation command
eval "$order_create_command"

#!/bin/bash

# WooCommerce credentials
WC_URL="https://benitto-backend.ngrok.dev"

# localhost:8003
CONSUMER_KEY="ck_24e32a83eaec640aea7f0a4f4ac8eecfd7338073"
CONSUMER_SECRET="cs_e23cf92e8a707ee6822a8f42222546bcf6d1a3bf"

# Number of reviews per product
REVIEWS_PER_PRODUCT=50

# Arrays of fake names (25+)
NAMES=(
  "Alice" "Bob" "Charlie" "David" "Eve" "Frank" "Grace" "Hannah"
  "Ivan" "Julia" "Kevin" "Laura" "Michael" "Nina" "Oscar" "Paula"
  "Quentin" "Rachel" "Steve" "Tina" "Uma" "Victor" "Wendy" "Xander"
  "Yara" "Zach"
)

# Function to generate fake Lorem Ipsum comment
generate_comment() {
    WORDS=("lorem" "ipsum" "dolor" "sit" "amet" "consectetur" "adipiscing" "elit" "sed" "do" "eiusmod" "tempor" "incididunt" "ut" "labore" "et" "dolore" "magna" "aliqua" "ut" "enim" "ad" "minim" "veniam")
    COUNT=$((RANDOM % 12 + 8))  # 8-20 words
    COMMENT=""
    for i in $(seq 1 $COUNT); do
        WORD=${WORDS[$RANDOM % ${#WORDS[@]}]}
        COMMENT="$COMMENT $WORD"
    done
    echo "${COMMENT^}."  # Capitalize first letter and add period
}

# Fetch product IDs (first 100 products, adjust per_page if needed)
PRODUCT_IDS=$(curl -s -u "$CONSUMER_KEY:$CONSUMER_SECRET" \
    "$WC_URL/wp-json/wc/v3/products?per_page=100" | jq -r '.[].id')

# Loop through each product
for PRODUCT_ID in $PRODUCT_IDS; do
    echo "Creating reviews for product ID $PRODUCT_ID..."

    for i in $(seq 1 $REVIEWS_PER_PRODUCT); do
        # Random reviewer and comment
        REVIEWER=${NAMES[$RANDOM % ${#NAMES[@]}]}
        EMAIL="${REVIEWER,,}$RANDOM@example.com"
        COMMENT=$(generate_comment)
        RATING=$((RANDOM % 5 + 1))  # rating 1-5

        # Create review
        curl -s -X POST "$WC_URL/wp-json/wc/v3/products/reviews" \
            -u "$CONSUMER_KEY:$CONSUMER_SECRET" \
            -H "Content-Type: application/json" \
            -d "{
                \"product_id\": $PRODUCT_ID,
                \"review\": \"$COMMENT\",
                \"reviewer\": \"$REVIEWER\",
                \"reviewer_email\": \"$EMAIL\",
                \"rating\": $RATING
            }" >/dev/null
    done

    echo "Created $REVIEWS_PER_PRODUCT reviews for product ID $PRODUCT_ID."
done

echo "All reviews created!"

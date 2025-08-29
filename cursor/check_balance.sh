#!/bin/bash

# Account Balance Checker Script
# Usage: ./check_balance.sh [testnet|mainnet]

set -e

# Default to testnet if no argument provided
NETWORK=${1:-testnet}

# Validate network parameter
if [[ "$NETWORK" != "testnet" && "$NETWORK" != "mainnet" ]]; then
    echo " Invalid network parameter. Use 'testnet' or 'mainnet'"
    echo "Usage: $0 [testnet|mainnet]"
    exit 1
fi

echo " Starting Account Balance Checker with $NETWORK configuration..."
echo " Loading environment variables from $NETWORK.env..."

# Load environment variables
if [[ -f "$NETWORK.env" ]]; then
    export $(grep -v '^#' "$NETWORK.env" | xargs)
    echo " Environment variables loaded from $NETWORK.env"
else
    echo " Environment file $NETWORK.env not found"
    exit 1
fi

# Display configuration
echo " Configuration:"
echo "  Network: $NETWORK"
echo "  Wallet: ${PRIVATE_KEY:0:10}..."
echo "  Symbol: $SYMBOL"
echo ""

# Run the balance checker
echo " Running balance check..."
poetry run python check_balance.py

echo ""
echo " Balance check completed for $NETWORK network"

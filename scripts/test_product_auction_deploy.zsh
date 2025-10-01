#!/bin/zsh

# Test script for deploy_product_auction.zsh
# This script validates the deployment script without actually deploying

set -e

echo "🧪 Testing Product Auction Deployment Script"
echo "============================================="

SCRIPT_PATH="./deploy_product_auction.zsh"

# Test 1: Help functionality
echo "✅ Test 1: Help functionality"
if $SCRIPT_PATH --help > /dev/null 2>&1; then
    echo "   ✓ Help command works"
else
    echo "   ✗ Help command failed"
    exit 1
fi

# Test 2: Script syntax validation
echo "✅ Test 2: Script syntax validation"
if zsh -n "$SCRIPT_PATH"; then
    echo "   ✓ Script syntax is valid"
else
    echo "   ✗ Script syntax errors found"
    exit 1
fi

# Test 3: Check script is executable
echo "✅ Test 3: Script permissions"
if [[ -x "$SCRIPT_PATH" ]]; then
    echo "   ✓ Script is executable"
else
    echo "   ✗ Script is not executable"
    exit 1
fi

# Test 4: Validate required functions exist
echo "✅ Test 4: Required functions validation"
REQUIRED_FUNCTIONS=(
    "check_prerequisites"
    "validate_parameters" 
    "build_contract"
    "upload_contract"
    "deploy_contract"
    "save_deployment_results"
    "display_results"
    "print_usage"
)

for func in "${REQUIRED_FUNCTIONS[@]}"; do
    if grep -q "^$func()" "$SCRIPT_PATH"; then
        echo "   ✓ Function '$func' exists"
    else
        echo "   ✗ Function '$func' not found"
        exit 1
    fi
done

# Test 5: Check for required variables
echo "✅ Test 5: Required variables validation"
REQUIRED_VARS=(
    "CONTRACT_NAME"
    "CONTRACT_DIR"
    "WASM_PATH"
    "LOG_DIR"
)

for var in "${REQUIRED_VARS[@]}"; do
    if grep -q "^$var=" "$SCRIPT_PATH"; then
        echo "   ✓ Variable '$var' defined"
    else
        echo "   ✗ Variable '$var' not found"
        exit 1
    fi
done

# Test 6: Check for error handling
echo "✅ Test 6: Error handling validation"
if grep -q "set -e" "$SCRIPT_PATH" && grep -q "trap cleanup EXIT" "$SCRIPT_PATH"; then
    echo "   ✓ Error handling mechanisms in place"
else
    echo "   ✗ Error handling mechanisms missing"
    exit 1
fi

# Test 7: Check for logging functionality
echo "✅ Test 7: Logging functionality validation"
if grep -q "DEPLOYMENT_LOG=" "$SCRIPT_PATH" && grep -q "log_with_timestamp" "$SCRIPT_PATH"; then
    echo "   ✓ Logging functionality implemented"
else
    echo "   ✗ Logging functionality missing"
    exit 1
fi

# Test 8: Validate contract-specific configuration
echo "✅ Test 8: Contract-specific configuration validation"
if grep -q "product-auction-contract" "$SCRIPT_PATH"; then
    echo "   ✓ Contract name correctly configured"
else
    echo "   ✗ Contract name not found"
    exit 1
fi

# Test 9: Check for JSON parsing
echo "✅ Test 9: JSON parsing validation"
if grep -q "jq -r" "$SCRIPT_PATH"; then
    echo "   ✓ JSON parsing with jq implemented"
else
    echo "   ✗ JSON parsing not found"
    exit 1
fi

# Test 10: Validate stellar CLI commands
echo "✅ Test 10: Stellar CLI commands validation"
STELLAR_COMMANDS=(
    "stellar contract build"
    "stellar contract upload"
    "stellar contract deploy"
)

for cmd in "${STELLAR_COMMANDS[@]}"; do
    if grep -q "$cmd" "$SCRIPT_PATH"; then
        echo "   ✓ Command '$cmd' found"
    else
        echo "   ✗ Command '$cmd' not found"
        exit 1
    fi
done

echo ""
echo "🎉 All tests passed! The Product Auction deployment script is ready to use."
echo ""
echo "Contract Information:"
echo "  Name: product-auction-contract"
echo "  Features: Product listings, bidding, auction management, shipping, verification"
echo "  Target: Stellar Testnet/Mainnet"
echo ""
echo "Next steps:"
echo "1. Ensure Stellar CLI is installed: cargo install stellar-cli"
echo "2. Install jq: brew install jq"
echo "3. Configure a Stellar profile: stellar config keys add <profile-name>"
echo "4. Run deployment: ./deploy_product_auction.zsh testnet"
echo ""
echo "📚 Documentation: See PRODUCT_AUCTION_README.md for detailed usage"

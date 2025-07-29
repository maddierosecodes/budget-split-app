# Fair Split Calculator Unit Tests

This document describes the comprehensive unit test coverage for the Fair Split Calculator feature.

## Test Structure

The tests are organized following the principle of building from base cases through increasingly complex scenarios to edge cases.

### Test Groups

#### 1. Base Cases

- **All values zero**: Tests that the calculator handles edge cases where all inputs are zero without producing NaN values
- **All values same non-zero**: Tests calculation consistency when all income and expense values are identical

#### 2. Equal Income, Different Spending

- **Partners earn same but spend differently**: Tests scenarios where both partners have equal income but different personal expenses

#### 3. Different Incomes

- **Partners earn differently**: Tests calculations with moderate income differences and joint income
- **One partner earns significantly more**: Tests extreme income disparity scenarios (83%/17% split)

#### 4. Edge Cases - Negative Remaining

- **One partner would have negative remaining**: Tests scenarios where 50/50 split would leave one partner in deficit
- **Both partners would have negative remaining**: Tests household deficit scenarios where total expenses exceed total income

#### 5. Complex Scenarios with Joint Income

- **Significant joint income**: Tests how joint income affects percentage calculations across all three split methods

#### 6. EvenEdge Separate Bills Specific Tests

- **Equal remaining after joint bills**: Tests the unique EvenEdge behavior where partners have equal remaining amounts after joint bills, then pay their own personal bills

#### 7. Calculation Integrity

- **Mathematical consistency**: Verifies that total spend + total remaining equals total income across all scenarios and split methods

## Split Methods Tested

### 1. 50/50 Split

- **Joint Bills**: All expenses pooled and split equally
- **Separate Bills**: Joint expenses split 50/50, personal expenses remain individual

### 2. Percentage Split

- **Joint Bills**: All expenses split based on income percentages
- **Separate Bills**: Joint expenses split by percentage, personal expenses remain individual

### 3. EvenEdge Split

- **Joint Bills**: Each partner ends up with equal remaining amounts
- **Separate Bills**: Equal remaining after joint bills, then each pays personal bills

## Key Test Features

### Edge Case Handling

- Division by zero protection (when all incomes are zero)
- Negative spend values (representing money transfers between partners)
- Negative remaining amounts (deficit scenarios)

### Currency String Parsing

- Handles positive currency values: "£123.45"
- Handles negative currency values: "£-123.45"
- Used in income conservation verification

### Mathematical Verification

- Income conservation: Total spend + total remaining = total income
- Cross-validation between different calculation methods
- Precision handling with floating-point arithmetic

## Test Data Patterns

The tests use realistic financial scenarios:

- Typical household incomes (£1000-£5000)
- Common expense ranges (£200-£1200)
- Joint income scenarios (salary bonuses, shared investments)
- Real-world disparity cases (one high earner, one part-time)

## Coverage

The test suite provides comprehensive coverage of:

- All three calculation methods
- Both bill-sharing scenarios for each method
- Edge cases and error conditions
- Mathematical consistency verification
- Real-world usage patterns

Total test count: **10 comprehensive test cases** covering all major scenarios and edge cases.

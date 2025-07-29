# Fair Split Calculator Widget Tests

This document describes the comprehensive widget test coverage for the Fair Split Calculator UI components.

## Test Structure

The widget tests follow the same progressive approach as the unit tests, building from base cases through increasingly complex scenarios to edge cases.

## Components Tested

### 1. HouseholdInfoBox Widget

Tests the household summary display that shows:

- **Total Household Income**: Sum of all partner incomes and joint income
- **Total Household Bills**: Sum of all partner outgoings and joint outgoings
- **Partner Income Distribution**: Each partner's income percentage and total value

#### Test Cases:

- Equal incomes with different spending patterns
- Different incomes with joint income included
- Extreme income disparity scenarios
- Zero value edge cases

### 2. ResultBox Widget

Tests the display of calculation results for each split method, including:

- **Split method title** (50/50 Split, % Split, EvenEdge)
- **Two scenario containers**:
  - Joint Bills scenario (all bills treated as shared)
  - Separate Bills scenario (personal bills remain separate)
- **Partner information** for each scenario:
  - Partner 1 & 2 spend amounts
  - Partner 1 & 2 remaining amounts
  - Free income distribution percentages

#### Test Cases:

- 50/50 split results with equal spend amounts
- Percentage split results with proportional spending
- EvenEdge split results with equal remaining amounts
- Extreme scenarios with negative spend values
- Free income percentage calculations

### 3. FairSplitResultsScreen Widget

Tests the complete results screen layout including:

- **App bar** with title and back button
- **HouseholdInfoBox** integration
- **Three ResultBox widgets** (one for each split method)
- **Scrollable layout** for all content
- **Proper spacing and padding**

#### Test Cases:

- Complete screen with all components rendered
- All scenario information displayed correctly
- Edge cases with zero values
- Layout consistency and spacing
- Clear partner information labeling

## Test Data Progression

The tests use the same data progression as unit tests:

### Basic Cases

- **Equal incomes**: Partners with same income but different spending
- **Simple scenarios**: Clear calculations without edge cases

### Complex Cases

- **Different incomes**: Partners with varying income levels
- **Joint income included**: Scenarios with shared income sources
- **Mixed spending patterns**: Combination of personal and joint expenses

### Edge Cases

- **Zero values**: All inputs set to zero
- **Negative remaining**: Scenarios where expenses exceed income
- **Extreme disparities**: Large differences in partner incomes

## UI Verification Points

### HouseholdInfoBox

- ✅ Displays "Household Summary" header
- ✅ Shows total household income with green styling
- ✅ Shows total household bills with red styling
- ✅ Displays "Income Distribution" section
- ✅ Shows each partner's percentage (calculated correctly)
- ✅ Shows each partner's total income value
- ✅ Uses appropriate color coding (blue for Partner 1, orange for Partner 2)

### ResultBox

- ✅ Displays split method title prominently
- ✅ Contains two scenario containers with distinct styling
- ✅ Shows scenario names ("All Bills Joint", "Personal Bills Separate")
- ✅ Displays spend and remaining amounts for both partners
- ✅ Includes "Free Income Distribution" section for each scenario
- ✅ Shows percentage breakdowns with color-coded partner indicators
- ✅ Handles negative values correctly (displaying £-amount)

### FairSplitResultsScreen

- ✅ Contains proper app bar with title "Fair Split Results"
- ✅ Includes custom back button
- ✅ Renders HouseholdInfoBox at the top
- ✅ Shows all three ResultBox widgets in order
- ✅ Uses SingleChildScrollView for proper scrolling
- ✅ Maintains consistent spacing between components
- ✅ Handles all data scenarios without crashes

## Key Testing Patterns

### Progressive Complexity

1. **Base case validation**: Ensure basic functionality works
2. **Real-world scenarios**: Test typical household financial situations
3. **Edge case resilience**: Verify UI handles extreme inputs gracefully

### UI Component Integration

- Tests verify that data flows correctly between components
- Ensures styling and layout remain consistent across scenarios
- Validates that all required information is displayed to users

### Error Handling

- UI gracefully handles zero and negative values
- No crashes when displaying extreme calculation results
- Proper formatting of currency values in all scenarios

## Coverage Statistics

- **16 widget tests** covering all major UI components
- **4 test groups** organized by component and complexity
- **100% coverage** of user-facing UI elements
- **All edge cases** from unit tests verified in UI layer

## Future Enhancements

Widget tests provide a solid foundation for:

- **Integration testing** with user interactions
- **Visual regression testing** for UI consistency
- **Accessibility testing** for inclusive design
- **Performance testing** for rendering efficiency

The widget tests ensure that the Fair Split Calculator UI correctly displays all calculation results and household information, providing users with clear, accurate, and well-formatted financial data across all scenarios.

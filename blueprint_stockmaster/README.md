# StockMaster-Pro Testing Guide

## Overview
This project uses **Cucumber.js** for behavior-driven development (BDD) to test the inventory management system against a **PostgreSQL** database. The architecture follows the **Repository Pattern** to decouple business logic from database operations.

### Architecture
- **Cucumber.js**: Executes Gherkin feature files and maps steps to JavaScript code.
- **PostgreSQL**: Database for storing inventory data (products, locations, and stock movements).
- **Repository Pattern**:
  - `StockMasterProRepository`: Handles all database queries (e.g., stock checks, movement records).
  - `StockMasterProService`: Contains business logic (e.g., validating stock movements).
  - `DatabaseConnection`: Manages the PostgreSQL connection pool.

### Files
- `04_business_specs.feature`: Gherkin feature file with scenarios for stock management.
- `steps/inventory_steps.js`: Step definitions that call the service layer.
- `repositories/`: Database interaction layer.
- `services/`: Business logic layer.

---

## Database Setup
Start the PostgreSQL database container:

```bash
docker compose -f compose.yaml up -d
```

Connect to the database:

```bash
docker exec -it stockmaster-pro-db psql -U postgres -d megashop
```

---

## Running Tests

### Run Tests Only (Assumes DB is Running)
```bash
npm test
```

### Full Test Workflow (Start DB, Run Tests, Stop DB)
```bash
npm run test:full
```

### Manual Database Control
- Start the database:
  ```bash
  npm run db:start
  ```
- Stop the database:
  ```bash
  npm run db:stop
  ```

---

## API Contract Validation

Lint the API contract using Spectral:

```bash
docker run --rm -it -v $(pwd):/tmp stoplight/spectral lint --ruleset "/tmp/.spectral.yaml" "/
tmp/03_api_contract.yaml"
```

Expected output:
```
No results with a severity of 'error' found!
```

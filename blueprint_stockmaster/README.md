# StockMaster-Pro Testing Guide

## Database Testing

Start the PostgreSQL database container:

```bash
docker compose up
```

Connect to the database:

```bash
docker exec -it stockmaster-pro-db psql -U postgres -d megashop
```

## API Contract Validation

Lint the API contract using Spectral:

```bash
docker run --rm -it -v $(pwd):/tmp stoplight/spectral lint --ruleset "/tmp/.spectral.yaml" "/tmp/03_api_contract.yaml"
```

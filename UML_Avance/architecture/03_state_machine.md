# State Machine

```mermaid
stateDiagram-v2
    [*] --> DRAFT
    DRAFT --> PENDING_PAYMENT: checkout_button_clicked
    PENDING_PAYMENT --> PAID: payment_success
    PENDING_PAYMENT --> FAILED: payment_failed
    FAILED --> PENDING_PAYMENT: retry_payment
    PAID --> SHIPPED: order_processed
    SHIPPED --> [*]
```
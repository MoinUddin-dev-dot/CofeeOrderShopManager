# ☕️ CofeeOrderShop

**CofeeOrderShop** is a SwiftUI-based iOS application that allows users to place, update, fetch, and delete coffee orders. It follows the MVVM architecture and makes use of modern Swift concurrency with `async/await`.

---

## 🛠️ Features

- ✅ Place a new coffee order
- 📋 View all orders
- 🔄 Update an existing order
- ❌ Delete an order
- 🧪 Validations on inputs
- 🎨 Custom SwiftUI view modifiers
- 🔤 String utility extensions
- 💵 Currency formatting

---

## 🧱 Architecture

The app is built using the **MVVM (Model-View-ViewModel)** pattern:

- `Model`: `Order.swift`, `CofeeSize`, and error enums.
- `ViewModel`: `CoffeeModel.swift` manages the state and logic.
- `Service`: `WebService.swift` handles all network requests.
- `Extensions`: Utility helpers for views, strings, and formatting.
- `Currency formatting`

---

## 📁 Project Structure

CofeeOrderShop/
│
├── Models/
│   └── Order.swift
│
├── Services/
│   └── WebService.swift
│
├── ViewModels/
│   └── CoffeeModel.swift
│
├── Extensions/
│   ├── View+Extension.swift
│   ├── String+Extensions.swift
│   └── NumberFormatter+Extensions.swift


## 📦 Dependencies

No external dependencies. Uses native Swift features such as:

- `@MainActor`, `@Published`, `ObservableObject`
- `async/await` for modern concurrency
- `Codable` for JSON encoding/decoding

---

## 🚀 API Endpoints (Configured via `Enviroment`)

> ⚠️ Replace `Enviroment` static paths with your actual server configuration.

| Method | Endpoint          | Description           |
|--------|-------------------|-----------------------|
| GET    | `/orders`         | Fetch all orders      |
| POST   | `/orders`         | Place new order       |
| PUT    | `/orders/{id}`    | Update an order       |
| DELETE | `/orders/{id}`    | Delete an order       |

---

## 🛠️ Extensions

- **`View+Extension.swift`**  
  Adds view modifiers:
  - `.centerHorizontally()` – Centers a view horizontally in a HStack  
  - `.visible(_:)` – Conditionally show/hide a view

- **`String+Extensions.swift`**  
  Adds string utilities:
  - `isNumeric()` – Checks if the string is a valid number  
  - `isNotEmpty` – Checks if string is not empty  
  - `isLessThan(number:)` – Compares numeric value of the string

- **`NumberFormatter+Extensions.swift`**  
  Adds:
  - `.currency` – A currency formatter instance using `.numberStyle = .currency`

---

## 🧪 Testing & Error Handling

All network requests handle:

- ❌ Invalid URLs
- 🚫 Bad HTTP responses (non-200 status codes)
- 🧨 JSON decoding errors

### 🧱 Custom Error Enums

- `NetworkError` – General networking and API failure cases
- `CoffeeOrderError` – Specific logic errors like invalid Order ID

---

# 🚚 Lohagara Carrier

### Smart Logistics. Smooth Deliveries.

Lohagara Carrier is a Flutter-based transport and billing management
application designed to simplify company, factory, trip, billing, and
report management through a centralized mobile application.

The application provides a structured workflow for managing companies
and factories, recording truck trips, tracking monthly financial data,
and generating professional business reports.

![Lohagara Carrier Showcase](screenshots/showcase/lohagara_carrier_showcase.png)

---

## ✨ Overview

Lohagara Carrier was developed as a practical logistics and transport
management solution for managing day-to-day transportation operations.

The application allows users to:

- Manage companies and factories
- Record and manage truck trips
- Track monthly transportation expenses
- Monitor business statistics through a dashboard
- Generate monthly and summary reports
- Generate professional PDF documents
- Maintain a searchable report history
- Preview, download, and share generated reports

The project follows a feature-based Clean Architecture approach with
GetX for state management and Firebase as the backend infrastructure.

---

## 🚀 Key Features

### 🔐 Authentication

- Firebase Authentication
- Secure user login
- Password reset
- Logout
- User profile management

---

### 🏢 Company Management

- Create and manage companies
- View company information
- Search companies
- Company-based factory management
- Delete companies with confirmation

---

### 🏭 Factory Management

- Create and manage factories
- Associate factories with companies
- View factory information
- Track factory-wise transportation activity
- Delete factories with confirmation

---

### 🚚 Transport Record Management

- Add new transportation records
- Edit existing records
- Delete records
- Company → Factory dependent selection
- Truck number management
- Fare calculation
- Load demurrage
- Unload demurrage
- Total amount calculation
- Unload point
- Item information
- Remarks
- Record search and filtering
- Paginated record loading

---

### 📊 Dashboard

The dashboard provides an overview of important business information,
including:

- Monthly billing
- Total trips
- Total demurrage
- Active factories
- Recent transportation records
- Quick actions

---

### 🧾 Monthly Billing

- Factory-wise monthly billing
- Automatic monthly bill number generation
- Monthly trip calculation
- Monthly total amount calculation
- Factory monthly aggregation
- Professional monthly bill generation

---

### 📑 Summary Reports

- Company-wise monthly summary
- Factory-wise trip summary
- Factory-wise amount summary
- Total trips
- Total amount
- Amount in words
- Professional summary report generation

---

### 📄 PDF Reporting

The application provides professional PDF report generation for both
monthly bills and summary reports.

#### Monthly PDF

- Factory name
- Billing month
- Bill number
- Detailed transportation table
- Fare
- Load demurrage
- Unload demurrage
- Total amount
- Unload point
- Item
- Remarks
- Total trips
- Total amount
- Amount in words

#### Summary PDF

- Company information
- Billing month
- Bill number
- Factory-wise summary
- Total trips
- Total amount
- Amount in words

---

### 📤 PDF Actions

Generated reports can be:

- 👁️ Previewed
- ⬇️ Downloaded
- 🔗 Shared

The application also uses separate PDF styling and layout logic for
different report types.

---

### 🗂️ Report History

Generated monthly and summary reports are stored in Firestore so that
users can access previously generated reports.

Features include:

- Report history
- Monthly reports
- Summary reports
- Search
- Report type filtering
- This month filtering
- Last three months filtering
- Report preview
- Report download
- Report sharing
- Report deletion with confirmation

---

### 🔍 Search & Filtering

The application provides search and filtering across the report history.

Users can search reports using:

- Company name
- Factory name
- Bill number
- Report type
- Month key

Available report filters include:

- All
- Monthly
- Summary
- This Month
- Last Three Months

Search and filters can also be combined.

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform application development |
| Dart | Programming language |
| GetX | State management and dependency injection |
| Firebase Authentication | User authentication |
| Cloud Firestore | Application database |
| Firebase Storage | File and media storage |
| PDF Package | PDF report generation |
| Intl | Date and number formatting |

---

## 🏗️ Architecture

The project follows a feature-based Clean Architecture approach.

```text
lib/
│
├── core/
│   ├── common/
│   ├── constants/
│   ├── exceptions/
│   ├── helpers/
│   └── ...
│
├── features/
│   │
│   ├── authentication/
│   │
│   ├── company/
│   │
│   ├── factory/
│   │
│   ├── record/
│   │
│   ├── dashboard/
│   │
│   └── report/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── presentation/
│       │   ├── history/
│       │   ├── monthly/
│       │   └── summary/
│       │
│       ├── builders/
│       └── services/
│
└── ...

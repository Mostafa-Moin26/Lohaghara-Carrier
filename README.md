# 🚚 Lohagara Carrier

### Smart Logistics. Smooth Deliveries.

Lohagara Carrier is a Flutter-based transport and billing management
application designed to simplify transportation records, factory
operations, monthly billing, and professional report generation.

The application provides a centralized workflow for managing transport
records, automatically maintaining company and factory information,
tracking monthly financial data, and generating professional PDF reports.

<p align="center">
  <img src="screenshots/showcase/lohagara_carrier_showcase.png"
       alt="Lohagara Carrier Showcase"
       width="850"/>
</p>

---

## 📌 Overview

Lohagara Carrier is a business-focused logistics and transport
management application built with Flutter and Firebase.

The application is designed around a record-based workflow where
transportation records are the core source of operational data.

When a user adds transportation records, the associated company and
factory information is automatically created and maintained as part of
the record workflow.

The collected data is then used for:

- Dashboard statistics
- Factory-wise monthly aggregation
- Monthly billing
- Company-wise summary reports
- PDF report generation
- Report history

The project follows a feature-based Clean Architecture approach and
uses GetX for state management and dependency injection.

---

# ✨ Key Features

## 🔐 Authentication

- Firebase Authentication
- User sign-in
- Password reset
- Logout
- User profile management

---

## 🏢 Company & Factory Management

Company and factory information are not managed through separate
manual CRUD screens.

Instead, they are automatically created and maintained through the
transportation record workflow.

### Company

- Company information is captured from transportation records
- Company-wise record organization
- Company-based factory relationship
- Reusable company information across records

### Factory

- Factory information is captured from transportation records
- Factory-to-company relationship
- Factory-wise transportation tracking
- Factory-wise monthly aggregation

---

## 🚚 Transport Record Management

Transportation records are the core operational data of the application.

### Record Features

- Add transportation records
- Edit existing records
- Delete records
- Company selection
- Factory selection based on company
- Truck number
- Fare
- Load demurrage
- Unload demurrage
- Total amount calculation
- Unload point
- Item information
- Remarks
- Record date
- Monthly record organization
- Record search
- Record filtering
- Paginated record loading

---

## 📊 Dashboard

The dashboard provides an overview of important transportation and
billing information.

### Dashboard Statistics

- Monthly billing
- Total trips
- Total demurrage
- Active factory count
- Recent transportation records
- Quick actions

The dashboard data is derived from the application's operational
records and monthly aggregation data.

---

# 🧾 Monthly Billing

Lohagara Carrier provides factory-wise monthly billing.

Users can select a factory and month to generate a monthly bill.

### Monthly Billing Features

- Factory-wise monthly billing
- Monthly trip calculation
- Monthly total amount calculation
- Monthly factory aggregation
- Automatic bill number generation
- Detailed transportation records
- Amount in words
- Professional PDF generation

---

# 📑 Summary Reports

The application also provides company-wise monthly summary reports.

A summary report aggregates transportation information across the
factories associated with a selected company.

### Summary Report Features

- Company-wise summary
- Month-wise summary
- Factory-wise trip summary
- Factory-wise amount summary
- Total factories
- Total trips
- Total amount
- Amount in words
- Professional PDF generation

---

# 📄 PDF Report Generation

Lohagara Carrier supports professional PDF generation for both monthly
billing and summary reports.

## Monthly Bill PDF

The monthly report can contain:

- Company information
- Factory information
- Billing month
- Bill number
- Transportation records
- Truck number
- Date
- Fare
- Load demurrage
- Unload demurrage
- Total amount
- Unload point
- Item
- Remarks
- Total trips
- Grand total
- Amount in words

## Summary Report PDF

The summary report contains:

- Company information
- Billing month
- Bill number
- Factory-wise summary
- Factory-wise trip count
- Factory-wise amount
- Total trips
- Total amount
- Amount in words

---

# 📤 PDF Actions

Generated reports can be:

- 👁️ Previewed
- ⬇️ Downloaded
- 🔗 Shared

The application uses dedicated PDF services and report builders to keep
report generation logic separated from the presentation layer.

---

# 🗂️ Report History

Generated reports are saved to Cloud Firestore so users can access
previously generated reports from the application.

The report history supports both:

- Monthly Reports
- Summary Reports

### Report History Features

- Firestore-based report history
- Monthly report history
- Summary report history
- Report search
- Report type filtering
- This Month filtering
- Last Three Months filtering
- Report preview
- PDF download
- PDF sharing
- Report deletion
- Delete confirmation dialog

---

# 🔍 Search & Filtering

Report History provides combined search and filtering functionality.

Users can search reports using:

- Company name
- Factory name
- Bill number
- Report type
- Month key

### Available Filters

- All
- Monthly
- Summary
- This Month
- Last Three Months

Search and filtering can be applied together to quickly find a
specific report.

---

# 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform application development |
| **Dart** | Programming language |
| **GetX** | State management and dependency injection |
| **Firebase Authentication** | User authentication |
| **Cloud Firestore** | Application database |
| **Firebase Storage** | File and media storage |
| **PDF Package** | PDF report generation |
| **Intl** | Date and number formatting |

---

# 🏗️ Architecture

The application follows a feature-based Clean Architecture approach.

The codebase separates presentation logic, data models, repositories,
business logic, builders, and services to improve maintainability and
scalability.

```text
lib/
│
├── core/
│   ├── common/
│   ├── constants/
│   ├── device/
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
│       │
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
├── routes/
│
└── app.dart

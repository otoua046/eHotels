# 🏨 eHotels - CSI2132 Project

<img width="1629" alt="Screenshot 2025-03-29 at 10 30 30 PM" src="https://github.com/user-attachments/assets/09721260-f5d1-40d8-a7d0-4eef8e0351e1" />
<img width="1629" alt="Screenshot 2025-03-29 at 10 31 23 PM" src="https://github.com/user-attachments/assets/b8f30cc8-6c9b-40c1-912f-a8791f6b0aea" />
<img width="1629" alt="Screenshot 2025-03-29 at 10 32 14 PM" src="https://github.com/user-attachments/assets/4823ca04-d425-4777-be3c-5df29686c8de" />
<img width="1629" alt="Screenshot 2025-03-29 at 10 31 48 PM" src="https://github.com/user-attachments/assets/5ae2c2d5-d28d-427e-a619-139f2602e14f" />




## 📚 Course
This project was developed as part of **CSI2132 - Databases** at the University of Ottawa. The goal of the course is to introduce students to practical and theoretical aspects of relational databases, including SQL, schema design, normalization, indexing, and database application development.

## 🌟 Features
This full-stack web application simulates an online hotel room booking and renting system. It includes the following features:

- **Search for rooms** based on location, type, view, price, and availability.
- **Book a room** as a customer.
- **Rent a room** as an employee either from a booking or directly.
- **View statistics** from MySQL views like available capacity per hotel or available rooms per area.
- **Employee dashboard** for easy access to bookings, rentings, and hotel insights.

## 📁 Project Structure
```
eHotels/
├── backend/
│   └── api/                   # PHP API endpoints
│       ├── create_customer.php
│       ├── create_booking.php
│       └── ... (more APIs)
├── database/                  # MySQL schema, inserts, views, and init script
│   ├── Creates/
│   ├── Indexes/
│   ├── Inserts/
│   ├── Queries/
│   ├── Triggers/
│   ├── Views/
│   ├── init_database.sql
│   ├── drop_database.sql
│   └── drop_all_tables.sql
├── frontend/                  # Angular 17 standalone frontend
│   ├── src/
│   ├── angular.json
│   └── ...
└── .gitignore
```

## 💻 Installation Guide

### 1. Requirements
- MySQL (e.g. using Homebrew or XAMPP)
- PHP 8+
- Node.js (v18+) and npm
- Angular CLI (v17+)

### 2. Database Setup
```bash
# Login to MySQL
mysql -u root -p

# Run the initialization script
SOURCE /path/to/eHotels/database/init_database.sql;
```

### 3. Backend (PHP API)
```bash
cd eHotels/backend/api
php -S localhost:8000
```
Make sure your PHP server is running at `http://localhost:8000`.

### 4. Frontend (Angular)
```bash
cd eHotels/frontend
npm install
ng serve --open
```
Angular should start on `http://localhost:4200`.

> 📝 You can test the APIs independently using Postman or any REST client.


## 📄 Useful Scripts

- `init_database.sql`: Creates and populates the database
- `drop_database.sql`: Drops the entire eHotels DB
- `drop_all_tables.sql`: Only drops tables, preserving the database

---

## 👨‍💼 Authors

- Sam Touahri — University of Ottawa
- Hannah Mary Jurewicz-Turner - University of Ottawa
- Katherine Casey - University of Ottawa

---

## 📝 License

This project is for academic and educational use only.

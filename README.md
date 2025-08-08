# Library Service API

A lightweight, high-performance RESTful API for managing a library system built using:

- **Sinatra** – simple yet powerful Ruby web framework
- **Puma** – concurrent HTTP server for Ruby/Rack apps
- **MySQL** – relational database
- **ActiveRecord** – ORM for database mapping
- **Layered Architecture** – clean separation with Controller → Service → Repository → Model

> Deployed on Railway: [https://library-service-production.up.railway.app](https://library-service-production.up.railway.app)

---

## Architecture
```angular2html
App/
│
├── controllers/
│   ├── books_controller.rb
│   ├── borrowers_controller.rb
│   └── loans_controller.rb
│
├── services/
│   ├── book_service.rb
│   ├── borrower_service.rb
│   └── loan_service.rb
│
├── repositories/
│   ├── book_repository.rb
│   ├── borrower_repository.rb
│   └── loan_repository.rb
│
├── models/
│   ├── book.rb
│   ├── borrower.rb
│   └── loan.rb
│
└── app.rb (entrypoint Sinatra app)
```
> This clean separation improves **maintainability**, **testability**, and **scalability**.

---

## Stack

| Component      | Tech                        |
|----------------|-----------------------------|
| Framework      | Sinatra                     |
| Server         | Puma                        |
| ORM            | ActiveRecord                |
| DB             | MySQL                       |
| Deployment     | Railway                     |
| Pattern        | Layered (Controller-Service-Repo-Model) |

---

## API Endpoints

### Books

#### List Book
```bash
curl -X GET https://library-service-production.up.railway.app/books
```

#### Create Book
```bash
curl -X POST https://library-service-production.up.railway.app/books \
  -d "title=Clean Code" \
  -d "isbn=9780132350884" \
  -d "stock=3" \
  -H "Content-Type: application/x-www-form-urlencoded"
```

#### Show Book
```bash
curl -X GET https://library-service-production.up.railway.app/books/1
```

#### Update Book
```bash
curl -X PUT https://library-service-production.up.railway.app/books/1 \
  -d "title=Clean Code Update" \
  -d "isbn=9780132350884" \
  -d "stock=3" \
  -H "Content-Type: application/x-www-form-urlencoded"
```

#### Delete Book
```bash
curl -X DELETE https://library-service-production.up.railway.app/books/1
```

### Borrowers

#### List Borrower
```bash
curl -X GET https://library-service-production.up.railway.app/books
```

#### Create Borrower
```bash
curl -X POST https://library-service-production.up.railway.app/borrowers \
  -d "id_card_number=12234454" \
  -d "name=deden farhan" \
  -d "email=deden.farhan@mail.com" \
  -H "Content-Type: application/x-www-form-urlencoded"
```

#### Show Borrower
```bash
curl -X GET https://library-service-production.up.railway.app/borrowers/1
```

#### Update Borrower
```bash
curl -X PUT https://library-service-production.up.railway.app/borrowers/1 \
  -d "id_card_number=12234455" \
  -d "name=deden farhan" \
  -d "email=deden.farhan@mail.com" \
  -H "Content-Type: application/x-www-form-urlencoded"
```

#### Delete Borrower
```bash
curl -X DELETE https://library-service-production.up.railway.app/borrowers/1
```

### Loans

#### List Loan
```bash
curl -X GET https://library-service-production.up.railway.app/loans
```

#### Create Loan
```bash
curl -X POST https://library-service-production.up.railway.app/loans \
  -d "book_id=1" \
  -d "borrower_id=1" \
  -d "due_date=2025-09-06" \
  -H "Content-Type: application/x-www-form-urlencoded"
```

#### Return Loan
```bash
curl -X PATCH https://library-service-production.up.railway.app/loans/1/return
```

---

## Deployment
### Run Locally
1. Install Rbenv
```bash
  rbenv install
  rbenv rehash
```
2. Install dependencies:
```bash
  bundle install
```
3. Setup DB:
```bash
  bundle exec rake db:create db:migrate
```
4. Start App:
```bash
  bundle exec puma -C puma.rb
```

### Docker Compose
1. Set environment variables:
```dotenv
APP_PORT=3000
APP_ENV=production
RACK_ENV=production
WEB_CONCURRENCY=2
MAX_THREADS=5

DB_ADAPTER=mysql2
DB_HOST=db
DB_PORT=3306
DB_NAME=library_db
DB_USER=root
DB_PASSWORD=P@ssw0rd
MAX_LOAN_DURATION_DAYS=30
```
2. Run docker compose:
```bash
docker compose up --build
```
### Using Railway
1. Push repo to GitHub 
2. Go to Railway 
3. Create new project → Link GitHub repo 
4. Add MySQL plugin 
5. Set environment variables:
```dotenv
DB_ADAPTER=mysql2
DB_HOST=mysql.railway.internal
DB_PORT=3306
DB_NAME=railway
DB_USER=root
DB_PASSWORD=your_mysql_password
```
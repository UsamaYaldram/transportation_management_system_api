# Transportation Management API

This project is a Ruby on Rails-based API for managing a transportation system. It provides endpoints for managing drivers, trucks, and their assignments, and supports authentication using JSON Web Tokens (JWT). Additionally, it offers Swagger API documentation and background job processing with Sidekiq.

---

## Features
- Driver creation and authentication with JWT.
- Truck management (list, assign to drivers).
- View assigned trucks and their details (including assignment dates).
- API documentation via Swagger.
- Background job processing with Sidekiq.
- Secure and structured API responses using JSON:API serialization.

---

## Prerequisites
Make sure you have the following installed:
- Ruby 3.1.4
- Rails 7.1.5
- PostgreSQL
- Redis
- Bundler

---

## Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:UsamaYaldram/transportation_management_system_api.git
   cd transportation_management_system_api
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Configure credentials:
   Add your environment variables (e.g., BASE_URL, API_KEY) using Rails credentials.
   ```bash
   EDITOR="code --wait" bin/rails credentials:edit
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

6. Start Sidekiq:
   ```bash
   bundle exec sidekiq
   ```

---

## API Endpoints

### Drivers
1. **Create Driver**
   - Endpoint: `POST /drivers`
   - Request Body:
     ```json
     {
       "driver": {
         "email": "driver@example.com",
         "password": "password123"
       }
     }
     ```
   - Response: JWT token.

2. **Driver Login**
   - Endpoint: `POST /drivers/login`
   - Request Body:
     ```json
     {
       "email": "driver@example.com",
       "password": "password123"
     }
     ```
   - Response: JWT token.

### Trucks
1. **Get All Trucks**
   - Endpoint: `GET /trucks`
   - Response: List of trucks.

2. **Assign Truck to Driver**
   - Endpoint: `POST /trucks/assign`
   - Query Parameters:
     - `truck_id` (integer): ID of the truck.
     - `driver_id` (integer): ID of the driver.
   - Response: Assignment success message.

3. **Get Assigned Trucks**
   - Endpoint: `GET /trucks/assigned`
   - Response: List of assigned trucks with assignment dates.

---

## Testing
Run tests using RSpec:
```bash
bundle exec rspec
```

---

## Gems Used
- **Rails**: Web application framework.
- **PostgreSQL**: Database.
- **Redis**: Background job storage.
- **Sidekiq**: Background job processing.
- **JWT**: Authentication.
- **JSONAPI::Serializer**: API response serialization.
- **Rswag**: API documentation (Swagger).
- **HTTParty**: HTTP requests.
- **Whenever**: Cron job scheduling.
- **Faker**: Test data generation.

---

## Development Tools
- **Byebug**: Debugging.
- **RSpec-Rails**: Testing framework.
- **FactoryBot-Rails**: Fixtures replacement.
- **Error Highlight**: Enhanced error visibility.

---

## Deployment
1. Ensure the database is migrated:
   ```bash
   rails db:migrate
   ```
2. Precompile assets:
   ```bash
   rails assets:precompile
   ```
3. Start the server in production:
   ```bash
   RAILS_ENV=production rails server
   ```

---

## License
This project is licensed under the MIT License.

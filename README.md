# Transportation Management API

Transportation Management API is a Rails application that provides endpoints to manage drivers and trucks in a transportation system. It includes features such as driver creation, login, assigning trucks to drivers, and retrieving assigned trucks.

## Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [API Documentation](#api-documentation)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

## Prerequisites

- Ruby 3.1.4
- Rails 7.1.5.1
- PostgreSQL
- Redis

## Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:UsamaYaldram/transportation_management_system_api.git
   cd transportation-management-api
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create db:migrate
   ```

4. Configure credentials for JWT and other secrets:
   ```bash
   rails credentials:edit
   ```

5. Start the server:
   ```bash
   rails server
   ```

## Usage

- To start Sidekiq for background jobs:
  ```bash
  bundle exec sidekiq
  ```

- To schedule cron jobs using Whenever:
  ```bash
  whenever --update-crontab
  ```

## API Documentation

Detailed API documentation is available at:
```
/api-docs/index.html
```
Access this URL in your browser after starting the Rails server.

## Testing

Run the test suite using RSpec:
```bash
bundle exec rspec
```

## Gems Used

- **Rails**: Web application framework.
- **PostgreSQL**: Database.
- **Sidekiq**: Background job processor.
- **Redis**: In-memory data structure store for Sidekiq.
- **JWT**: JSON Web Token for authentication.
- **Rswag**: Swagger documentation.
- **Jsonapi-serializer**: JSON:API serialization.
- **Httparty**: HTTP request handling.
- **Whenever**: Cron job scheduling.
- **RSpec**: Testing framework.
- **FactoryBot**: Test data setup.
- **Faker**: Fake data generator.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License.

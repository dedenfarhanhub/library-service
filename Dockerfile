FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libmariadb-dev netcat-openbsd

# Set working directory
WORKDIR /app

# Copy gemfiles and install gems
COPY Gemfile* ./
RUN bundle install

# Copy all project files
COPY . .

# Expose port
EXPOSE ${APP_PORT}

# Run Puma via Entrypoint
CMD ["bundle", "exec", "puma", "-C", "puma.rb"]

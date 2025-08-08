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

COPY .docker/entrypoint.sh /usr/bin/entrypoint.sh
COPY .docker/wait-for-mysql.sh /usr/bin/wait-for-mysql.sh
RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/wait-for-mysql.sh

# Expose port
EXPOSE ${APP_PORT}

# Run Puma via Entrypoint
ENTRYPOINT ["/usr/bin/entrypoint.sh"]


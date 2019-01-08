FROM openjdk:8

# install Chrome
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	--no-install-recommends

RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
	&& apt-get update \
  && apt-get install -y google-chrome-stable --no-install-recommends

# install xvfb for Cypress
RUN apt-get install -y \
  libgtk2.0-0 \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  xvfb --no-install-recommends

# install psql
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && wget "http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4_amd64.deb" \
  && dpkg -i libssl1.0.0_1.0.2g-1ubuntu4_amd64.deb \
  && apt-get update \
  && apt-get install postgresql-client postgresql-client-11 libpq5 -y

RUN apt-get purge --auto-remove -y curl gnupg \
  && rm -rf /var/lib/apt/lists/*


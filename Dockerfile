FROM ubuntu:latest

EXPOSE 8090

RUN apt-get update -qqy \
  && apt-get -qqy install git curl \
  && apt-get -qqy install chromium-browser \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN git clone https://github.com/ChromeDevTools/devtools-frontend.git

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
RUN bash -ci "nvm install --lts"

WORKDIR devtools-frontend

RUN sed -i.orig s/"var chromeArgs = \["/"var chromeArgs = \[\n  \`--no-sandbox\`,\n  \`--headless\`,\n  \`--disable-gpu\`,"/g scripts/chrome_debug_launcher/launch_chrome.js

ENV CHROMIUM_PATH=/usr/bin/chromium-browser

ENTRYPOINT ["/bin/bash", "-ci", "npm start"]
#ENTRYPOINT ["/bin/bash", "-ci", "npm", "start"]


FROM ubuntu:latest

EXPOSE 8090

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy \
  && apt-get -qqy install git curl \
  && apt-get -qqy install chromium-browser \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN git clone https://github.com/ChromeDevTools/devtools-frontend.git

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
	&& . ~/.bashrc \
	&& nvm install --lts
#	&& npm i chrome-devtools-frontend
#WORKDIR node_modules/chrome-devtools-frontend
WORKDIR devtools-frontend

#RUN sed -i s/"var chromeArgs = \["/"var chromeArgs = \[\n  \`--no-sandbox\`,\n  \`--headless\`,\n  \`--disable-gpu\`,"/g scripts/chrome_debug_launcher/launch_chrome.js

ENV CHROMIUM_PATH=/usr/bin/chromium-browser

#ENTRYPOINT ["/bin/bash", "-ci", "npm start"]
#ENTRYPOINT ["/bin/bash", "-ci", "npm", "start"]

ENTRYPOINT ["/bin/bash", "-ci", "npx http-server -i false -d false -p 8090"]

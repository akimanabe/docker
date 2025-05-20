FROM rocker/verse:latest

ENV LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8 \
    TZ=Asia/Tokyo

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-ipaexfont \
        fonts-noto-cjk \
        locales \
        tzdata \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libgit2-dev \
        libpng-dev \
        libjpeg-dev \
        libcairo2-dev \
        libgl1-mesa-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libtiff5-dev && \
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install required R packages including ggpattern
RUN R -e "install.packages(c('tidyverse', 'gridExtra', 'devtools', 'remotes'), repos='https://cloud.r-project.org')" && \
    R -e "remotes::install_github('coolbutuseless/ggpattern')" && \
    R -e "devtools::install_github('ichimomo/frasyr@dev')"

CMD ["/init"]

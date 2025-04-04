FROM debian:bookworm-slim AS build
 ARG RADICALE_URL=git+https://github.com/koalyorg/radicale-sql.git

RUN apt-get update && apt-get install -y \
    git \
    python3-mysqldb \
    radicale \
    python3-radicale-dovecot-auth \
    python3-pip
RUN python3 -m pip install --break-system-packages --root-user-action ignore ${RADICALE_URL} 
RUN python3 -m pip install --break-system-packages --root-user-action ignore sqlalchemy 

COPY ./default.conf /radicale/conf/default.conf
EXPOSE 5232

CMD ["python3", "-m",  "radicale", "--config", "/radicale/conf/default.conf"]

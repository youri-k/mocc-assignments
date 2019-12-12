FROM debian
RUN apt-get update && apt-get install -y gcc python3 fio
WORKDIR /app
CMD ./benchmarks
FROM debian
RUN apt-get update && apt-get install -y gcc python3
WORKDIR /app
CMD ./benchmarks
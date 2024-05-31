FROM alpine:3.20 AS builder

RUN apk add build-base cmake && mkdir /app && mkdir /app/build

WORKDIR /app

COPY . .

RUN cmake -B ./build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build ./build --config Release

FROM alpine:3.20

RUN apk add libstdc++ && mkdir /app 

WORKDIR /app

COPY --from=builder /app/build/hello /app/hello

CMD [ "/app/hello" ]

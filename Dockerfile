FROM gcr.io/distroless/cc-debian12:nonroot

WORKDIR /app
COPY bin/silicium_hash_bench /app/bin/silicium_hash_bench

ENTRYPOINT ["/app/bin/silicium_hash_bench"]

# Import environment variables from .env file if it exists
set dotenv-load := true

# Default service name
SERVICE := env_var_or_default("SERVICE", "mempool-rebroadcaster")

# Run linting checks
lint:
    cargo fmt -- --check
    cargo clippy --all-targets --all-features -- -D warnings

# Run tests
test:
    cargo test --all-targets --all-features

# Run mempool rebroadcaster service
run-mempool-rebroadcaster:
    cargo run -p mempool-rebroadcaster -- --geth-mempool-endpoint {{env_var("GETH_MEMPOOL_ENDPOINT")}} --reth-mempool-endpoint {{env_var("RETH_MEMPOOL_ENDPOINT")}}

# Run flashblocks archiver service
run-flashblocks-archiver:
    cargo run -p flashblocks-archiver -- --database-url {{env_var("DATABASE_URL")}} --builder-urls {{env_var("FLASHBLOCKS_WEBSOCKET_URLS")}}

# Run flashblocks archiver with config file
run-flashblocks-archiver-config CONFIG_FILE:
    cargo run -p flashblocks-archiver -- --config {{CONFIG_FILE}}

# Build Docker image
docker-image:
    docker build --platform linux/amd64 --build-arg SERVICE_NAME={{SERVICE}} -t {{SERVICE}} .
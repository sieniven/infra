-include .env

SERVICE ?= mempool-rebroadcaster

lint:
	cargo fmt -- --check
	cargo clippy --all-targets --all-features -- -D warnings

run-mempool-rebroadcaster:
	cargo run -- --geth-mempool-endpoint $(GETH_MEMPOOL_ENDPOINT) --reth-mempool-endpoint $(RETH_MEMPOOL_ENDPOINT)

docker-image:
	docker build --platform linux/amd64 --build-arg SERVICE_NAME=$(SERVICE) -t $(SERVICE) .
.PHONY: verify

verify:
	cargo fmt --check
	cargo clippy -- -D warnings
	cargo check
	cargo test

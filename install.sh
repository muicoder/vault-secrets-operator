#!/bin/bash
set -e
go mod tidy
git diff | grep "^[+-]" || true
for GOARCH in amd64 arm64; do
  export GOARCH=$GOARCH
  mkdir -p .git/$GOARCH
  make ci-build
  cp -av "dist/linux/$GOARCH" .git
done

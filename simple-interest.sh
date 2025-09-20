#!/usr/bin/env bash
# simple-interest.sh - compute simple interest: SI = P * R * T, with R in percent

set -euo pipefail

usage() {
  echo "Usage: $0 <principal> <rate_percent> <time_years>"
  echo "Example: $0 1000 5 2   # => Simple Interest = 100.00"
  exit 1
}

if [ "${1-}" = "-h" ] || [ "${1-}" = "--help" ]; then
  usage
fi

if [ $# -ne 3 ]; then
  echo "Error: expected 3 arguments."
  usage
fi

P="$1"
R="$2"
T="$3"

# Basic validation (numbers)
re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $P =~ $re && $R =~ $re && $T =~ $re ]]; then
  echo "Error: all arguments must be numbers." >&2
  exit 2
fi

# bc handles floating point math
SI=$(echo "scale=2; $P * ($R/100) * $T" | bc -l)

printf "Simple Interest = %.2f\n" "$SI"

#!/usr/bin/env bash

set -euo pipefail

echo "=== X.509 Test Certificate Generator ==="
echo

# ---- Filenames ----
read -rp "Public certificate filename (e.g. mycert.cer): " CERT_FILE
read -rp "Private key filename (e.g. mykey.key): " KEY_FILE
read -rp "PFX filename (e.g. mycert.pfx): " PFX_FILE
echo

# ---- Passwords ----
# One password used for both the encrypted key and the PFX
read -srp "Password for private key and PFX: " KEY_PFX_PASS
echo
read -srp "Confirm password: " KEY_PFX_PASS_CONFIRM
echo

if [[ "$KEY_PFX_PASS" != "$KEY_PFX_PASS_CONFIRM" ]]; then
  echo "Error: Passwords do not match." >&2
  exit 1
fi

echo

# ---- Subject fields ----
echo "Enter certificate subject fields (press Enter to leave a field empty):"
read -rp "  Country Name (C, e.g. US): " C
read -rp "  State or Province (ST, e.g. California): " ST
read -rp "  Locality (L, e.g. San Francisco): " L
read -rp "  Organization (O, e.g. MyCompany): " O
read -rp "  Organizational Unit (OU, e.g. IT): " OU
read -rp "  Common Name (CN, e.g. test.example.local): " CN
echo

read -rp "Days the cert should be valid for (365 = 1 year, 36500 = Max): " DAYS_VALID
echo

# Build the -subj string, skipping empty components
SUBJ="/"
[[ -n "$C"  ]] && SUBJ="${SUBJ}C=$C/"
[[ -n "$ST" ]] && SUBJ="${SUBJ}ST=$ST/"
[[ -n "$L"  ]] && SUBJ="${SUBJ}L=$L/"
[[ -n "$O"  ]] && SUBJ="${SUBJ}O=$O/"
[[ -n "$OU" ]] && SUBJ="${SUBJ}OU=$OU/"
[[ -n "$CN" ]] && SUBJ="${SUBJ}CN=$CN/"

# Remove possible trailing slash (cosmetic)
SUBJ="${SUBJ%/}"

echo "Subject will be: $SUBJ"
echo

# ---- Generate private key + self-signed cert ----
echo "Generating encrypted private key and long-lived self-signed certificate..."
openssl req \
  -x509 \
  -newkey rsa:2048 \
  -keyout "$KEY_FILE" \
  -out "$CERT_FILE" \
  -days "$DAYS_VALID" \
  -sha256 \
  -passout "pass:$KEY_PFX_PASS" \
  -subj "$SUBJ"

echo "Created:"
echo "  Private key: $KEY_FILE"
echo "  Public cert: $CERT_FILE"
echo

# ---- Create PFX (PKCS#12) bundle ----
echo "Creating PFX (PKCS#12) bundle..."
openssl pkcs12 \
  -export \
  -inkey "$KEY_FILE" \
  -in "$CERT_FILE" \
  -out "$PFX_FILE" \
  -passin  "pass:$KEY_PFX_PASS" \
  -passout "pass:$KEY_PFX_PASS"

echo "Created:"
echo "  PFX bundle: $PFX_FILE"
echo

echo "Done. Key, cert, and PFX all use the same password you entered."

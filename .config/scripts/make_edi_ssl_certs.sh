#!/usr/bin/env zsh

# 02/03/2026 - SGB
# Make .cer, .pfx cert files and create files containing the base64
# content of each cert.

# Pass in the base name for the cert files as $1

certName=$1
certPassword=$2
certEnvironment=$3
certDaysValid=$4

if [[ "$certName" == "" || "$certPassword" == "" || "$certEnvironment" == "" || "$certDaysValid" == "" ]]; then
    echo """
    Must pass in the following arguments:
        Arg 1: Cert Name
        Arg 2: Cert Password
        Arg 3: Cert Environment
        Arg 4: Days cert is valid for
            Maximum days is 36500
    Example:
        ./make_edi_ssl_certs.sh <CertName> <CertPassword> <CertEnvironment> <CertDaysValid>
        ./make_edi_ssl_certs.sh FAITTESTCERT TestPassword.123! QA 365
    """
    exit
fi

cerFile="${certName}_${certEnvironment}.cer"
pfxFile="${certName}_${certEnvironment}.pfx"
keyFile="${certName}_${certEnvironment}.key"
derFile="${certName}_${certEnvironment}.der"
commonName="$certEnvironment $certName"

openssl req -x509 -newkey rsa:2048 \
    -keyout "$keyFile" \
    -out "$cerFile" \
    -days "$certDaysValid" \
    -nodes \
    -subj "/C=US/ST=Wisconsin/L=Burlington/O=Fait Companies/OU=IT/CN=$commonName/emailAddress=sbrewer@faitco.com"

openssl pkcs12 -export \
    -out "$pfxFile" \
    -inkey "$keyFile" \
    -in "$cerFile" \
    -password pass:"$certPassword"

base64 -i "$pfxFile" -o "$pfxFile.b64"

openssl x509 -in "$cerFile" -outform der -out "$derFile"

base64 -i "$derFile" -o "$cerFile.b64"

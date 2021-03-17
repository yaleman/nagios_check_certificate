#!/bin/bash

# test_check_certificate.sh

FAILED=0
if [ "$(./check_certificate revoked.badssl.com --depth=3 --port=443 2>/dev/null | grep -cE "^(CRITICAL|WARNING) revoked.badssl.com$")" -ne 1 ]; then
    FAILED=1
    echo "Failed to check revoked"
fi
if [ "$(./check_certificate expired.badssl.com --depth=3 --port=443 2>/dev/null | grep -cE "^(CRITICAL|WARNING) expired.badssl.com$")" -ne 1 ]; then
    FAILED=1
    echo "Failed to check expired"
fi
if [ "$(./check_certificate wrong.host.badssl.com --depth=3 --port=443 2>/dev/null | grep -cE "^(CRITICAL|WARNING) wrong.host.badssl.com$")" -ne 1 ]; then
    FAILED=1
    echo "Failed to check wrong.host"
fi
if [ "$(./check_certificate untrusted-root.badssl.com --depth=5 --port=443 2>/dev/null | grep -cE "^(CRITICAL|WARNING) untrusted-root.badssl.com$")" -ne 1 ]; then
    FAILED=1
    echo "Failed to check untrusted-root"
fi
if [ "$(./check_certificate pinning-test.badssl.com --depth=5 --port=443 2>/dev/null | grep -cE "^(CRITICAL|WARNING) pinning-test.badssl.com$")" -ne 1 ]; then
    FAILED=1
    echo "Failed to check pinning-test"
fi
if [ "${FAILED}" -eq 0 ]; then
    echo "Success!"
fi
exit "${FAILED}"
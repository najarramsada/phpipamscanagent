#!/bin/bash
docker run --rm --network=host -v /src/config.php:/ipamscan/config.php imanage/phpipamscan-alpine:1.0

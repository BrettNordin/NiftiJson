#!/bin/bash
sed 's/^/mv -vi "/;s/, /" "/;s/$/";/' < names.csv | bash -
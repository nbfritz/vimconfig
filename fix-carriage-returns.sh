#!/bin/bash
find . -iname *.vim -exec dos2unix -f {} \;

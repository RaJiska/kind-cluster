#!/bin/bash
for i in `seq 10`; do
	curl localhost/foo -s >/dev/null
	curl localhost/bar -s >/dev/null
done
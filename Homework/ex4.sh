#!/bin/bash

CMD='top -bn1'

OUTDIR=$(mktemp -d)
for PORT in $(seq 8000 9990);do
    if ! ss -ltn | awk '{print $4}' | grep -q ":$PORT$"; then
        break
    fi
done

cd "$OUTDIR" && python3 -m http.server "$PORT" &

echo "Server started on: http://localhost:$PORT"

while : ; do
    {
    cat <<"EOF"

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="10">
</head>
<body>
<pre>
EOF
    eval "$CMD"
    cat <<"EOF"
</pre>
</body>
</html>
EOF
    } > "$OUTDIR/index.html"
    sleep 10
done

#!/bin/bash

CMD='top -bn1'

OUTDIR=$(mktemp -d)
cd "$OUTDIR" && python3 -m http.server 8500 &


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

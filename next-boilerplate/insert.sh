function insert() {
    local FILENAME=$1
    local BOILERPLATE=$2
    cat >$FILENAME <<EOF
$BOILERPLATE 
EOF
}

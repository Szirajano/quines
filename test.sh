#!/usr/bin/bash
keep=false

# Handling cli args
if [ $# -gt 0 ]; then
    if [[ $1 != "-k" || $# -ne 1 ]]; then
        echo "Usage: test.sh [-k]"
        echo "-k: For keeping the temporary output files (they all match quine.*.txt)"
        return 1
    else
        keep=true
    fi
fi

# C quine
echo "C quine ----------------------------------"
gcc quine.c -o quine.c.out
./quine.c.out > quine.c.txt
diff quine.c quine.c.txt
if [ $? -eq 0 ]; then
    echo "Success"
fi
# Python quine
echo "Py quine ---------------------------------"
python3 quine.py > quine.py.txt
diff quine.py quine.py.txt
if [ $? -eq 0 ]; then
    echo "Success"
fi

# Cleanup
if [ "$keep" = false ]; then
    rm -f quine.*.out
    rm -f quine.*.txt
fi

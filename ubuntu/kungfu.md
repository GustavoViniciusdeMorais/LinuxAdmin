# Kung Fu Tips
```bash
grep -in '.*product.*' $(grep -rl product src/)
```
```bash
awk -F: '{print $1,$NF}' /etc/passwd | sort | column -t

history | awk '{print $2}' | sort | uniq -c | sort -rn | tail -5

echo "dev ops" | awk '{print $2}'

uptime

!u

echo "dev ops linux" | cut -d' ' -f2

echo "dev ops linux" | tr "ops" "abc"

df -mt ext4 | awk '{sum += $3} END {print sum}'

du -s /home/* | sort -n | head -3

# r is for reverse, 4 is the number of the column
ps aux | sort -nrk 4 | head -4
```
### modify string with tr
```bash
echo $PATH | tr ':' '\n'
echo "abc" | tr 'a' 'x'
echo "abc" | tr [:lower:] [:upper:]
```
### files diff
```bash
echo "linux" > test1.txt
echo "php" > test2.txt
diff test1.txt test2.txt
```
### search text in files of dir
./search.sh /path/to/directory "text to search"
```bash
#!/bin/bash

dir="$1"
text="$2"

search_files() {
    for item in "$1"/*
    do
        if [ -d "$item" ]; then
            search_files "$item"
        elif [ -f "$item" ]; then
            search=$(grep -in ".*$text.*" "$item" 2>/dev/null)
            if [ -n "$search" ]; then
                echo "Checking: $item"
                ls -lhs "$item"
                echo "$search"
                echo "---"
            fi
        fi
    done
}

search_files "$dir"
```

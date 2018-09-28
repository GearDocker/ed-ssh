export NEWSTRING=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1`
echo $NEWSTRING >> README.md
git commit -a -m "autochange build string $NEWSTRING"; git push


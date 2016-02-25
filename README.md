dots
====

My dot-files (.bash_profile etc.)

Install with ```./install.sh```


### Troubleshooting
If you run update and get a merge conflict for dots, you can reset your installation by running these commands in the dots-repo:
```sh
# fetch from the default remote, origin
git fetch
# reset your current branch (master) to origin's master
git reset --hard origin/master
# Reinstall dots
./install.sh
```

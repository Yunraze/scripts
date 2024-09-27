# Export GPG keys for migration

## Start by finding the key(s) id you want to migrate by using this command:

```sh
gpg --list-secret-keys --keyid-format LONG
```

It should returns something like:

```
sec   rsa4096/[**YOUR KEY ID**] 2024-03-30 [SC]
      ABCDEFGHIJKLMNOPQRSTUVWXYZ
uid                 [ unknown] username (KEY NAME) <user@domain>
ssb   rsa4096/ABCDEFGHIJKL 2024-03-30 [E]
```

After the key size rsa4096/ is your key ID.

## Export the key in preparation to move it

```sh
gpg --export -a [your key id] > gpg-pub.asc
```

## Prepare the secret key for migration (if password protected, you’ll be prompted to enter it)

```sh
gpg --export-secret-keys -a [your key] > gpg-sc.asc
```

Drag the key pair from the current directory to your USB stick or however else you move them (you can copy/past the first as they are just a text files).

## Once on the new machine, import them

```sh
gpg --import gpg-pub.asc
gpg --import gpg-sc.asc
```


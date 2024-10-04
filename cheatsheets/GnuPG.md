# GnuPG cheatsheet

## List all keys

```sh
gpg --list-secret-keys --keyid-format LONG
```

## Exporting keys

```sh
gpg -o key.gpg --export <KEY ID>
```

### Export a key in ASCII

```sh
gpg -o key.asc --armor --export <KEY ID>
```

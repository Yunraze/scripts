# GnuPG cheatsheet

## List all keys

```sh
gpg --list-secret-keys --keyid-format LONG
```

## Importing keys

```sh
gpg --import KEY_FILE
```

**NOTE:** The key file is usually named `.gpg` or `.asc.`

## Exporting keys

```sh
gpg -o key.gpg --export KEY_ID
```

### Export a key in ASCII

```sh
gpg -o key.asc --armor --export KEY_ID
```

**NOTE:** Omitting the `-o|--output` option will print the key to `stdout`.

## Managing the keyring

### Generating a new key

```sh
gpg --full-gen-key
```

### List all public keys

```sh
gpg --list-keys
gpg -k
```

### List secret keys

```sh
gpg -K
gpg --list-secret-keys
```

## Using a keyserver

### Import keys from keyserver

```sh
gpg --receive-keys KEY_ID
```

### Upload keys to keyserver

```sh
gpg --send-keys KEY_ID
```

### Update keys in the keyring from the keyserver

```sh
gpg --refresh-keys
```

### Search for a key from keyserver

```sh
gpg --search-keys SEARCH_STRING
```

### Override keyservers listed in `~/.gnupg/gpg.conf`

```sh
gpg --keyserver URL
```

## Trusting a key

```sh
gpg --edit-key KEY_ID
```

**ALTERNATIVELY**

```sh
gpg> trust
gpg> save
```

**NOTE**: The key owner's email or name, or any part of it, can be used instead of the key ID for `--edit-key`

## Encryption

### Public key encryption

Produces an encrypted file, `filename.txt.gpg`, that can only be decrypted by the `RECIPIENT`:

```sh
gpg -e -o secret.txt.gpg -r RECIPIENT secret.txt
```

`RECIPIENT` can be either their key ID, email or the name or a part of it.

```sh
gpg -e -r KEY_ID
gpg -e -r "Name"
gpg -e -r "email.address@example.com"
```

Specifying multiple recipients

```sh
gpg -e -r RECIPIENT -r ANOTHER_RECIPIENT ... secret.txt
```

**NOTE:** Omitting `-o|--output` will produce an encrypted file with a `.gpg` extension. This is typically the original filename + `.gpg`.

### Symmetric encryption

For encrypting a file using a shared key.

```sh
gpg --symmetric secret.txt
```

```sh
gpg -c secret.txt
```

## Decryption

### Decrypting a file

```sh
gpg -d -o secret.txt secret.txt.gpg
```

**NOTE:** Omitting `-o|--output` will print the contents to `stdout`.

## Signing

### Sign any file

```sh
gpg -o signed-file.txt.gpg -s file.txt
```

You can also use signing during encryption, to sign encrypted files:

```sh
gpg -s -o secret.txt.gpg -r RECIPIENT secret.txt
```
### Verifying a signature

```sh
gpg --verify file.txt.gpg
```

### View contents of a signed file

```sh
gpg -d signed-file.txt.gpg
```

## Miscellaneous

### Components

#### List all components

```sh
gpgconf --list-components
```

#### Kill a component

```sh
gpgconf --kill COMPONENT
```

#### Kill all components

```sh
gpgconf --kill all
```
### Parsing keyring data

Use `--with-colons` to produce an output that can easily be parsed with for example `awk` or `grep`. Fields are colon-separated.

```sh
gpg -k --with-colons
```
| Field #  | Description |  
| -------- | ----------- |
| 1 | Record type |
| 2 |	Validity |
| 3 |	Key length in bits |
| 4 |	Public key algorithm |
| 5 |	Key ID |
| 6 |	Creation date |
| 7 |	Expiry date |
| 8 |	Certificate S/N, UID hash, trust signature info |
| 9 |	Ownertrust |
| 10 | User ID |
| 11 | Signature class |
| 12 | Key capabilities |
| 13 | Issuer fingerprint |
| 14 | Flag field |
| 15 | S/N of token |
| 16 | Hash algorithm |
| 17 | Curve name |
| 18 | Compliance flags |
| 19 | Last update timestamp |
| 20 | Origin |

**Table 1:** Field quick reference

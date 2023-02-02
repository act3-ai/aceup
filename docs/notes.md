# Notes

## Special Cases Found

- User could not clone with SSH. They had an SSH key existing already and the script seemed to be creating everything correctly. I believe homebrew was trying to prompt for the passphrase on that key, but the prompt wasn't visible. Wondering if the ssh-agent wasn't surfacing our key? Or it chose the default anyways?
- User created token and checked every box for the token's "scopes", not just the "api" scope. When trying to use token with project tool, they could not access the catalog.

# Adding a Third-Party Repository

```bash
# 1. Navigate to sources directory
cd /etc/apt/sources.list.d/
# Purpose: All custom repos live here as .list files, separate from main sources.list

# 2. Download and add the GPG key
curl -fsSL https://example.com/repo.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/repo.gpg
# Purpose: Downloads the repo's signing key and saves it properly; GPG verifies package authenticity

# 3. Create the source list file
sudo nano repo.list
# Purpose: Creates/edits a file defining where to fetch packages from

# 4. File content example:
deb [arch=amd64 signed-by=/etc/apt/keyrings/repo.gpg] https://example.com/repo stable main
# [arch=amd64]      = only fetch 64-bit packages (skip i386 warnings)
# signed-by=        = path to the key that signed these packages
# stable            = distribution codename (or use $(lsb_release -cs) for auto-detect)
# main              = component (main, universe, contrib, etc.)

# 5. Update package lists
sudo apt update
# Purpose: Fetches the latest package index from all configured repos
```

## Removing a Repository
```bash
sudo rm /etc/apt/sources.list.d/repo.list
sudo rm /etc/apt/keyrings/repo.gpg   # optional: clean up the key
sudo apt update
```

## References
- Official Debian documentation: https://wiki.debian.org/SourcesList
- Ubuntu manpage: https://manpages.ubuntu.com/manpages/jammy/en/man5/sources.list.5.html
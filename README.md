# docker-alpine-dirb

Alpine-based image to run [dirb](https://sourceforge.net/projects/dirb/) scanner

## Usage

```bash
docker run --it -rm wildwildanger/dirb --help
```

Word lists bundled with `dirb` were placed into `/usr/share/dirb/wordlists` directory.

### Mountpoints

  * `/usr/share/dirb`: directory with word lists;
  * `/.cache`: dirb's working directory

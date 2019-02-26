# docker-pastebin
A dev oriented pastebin like container for sharing code and text. A lot more usefull though, thanking [John Crepezzi](https://github.com/seejohnrun) Paste your stuff however :)

# Quickstart

## Run
```bash
docker run --name pastebin -p 80:80 mkodockx/docker-pastebin
```

## Compose
```yaml
pastebin:
  image: mkodockx/docker-pastebin
```
# Settings

## Overview

* `host` - the host the server runs on (default localhost)
* `port` - the port the server runs on (default 7777)
* `keyLength` - the length of the keys to user (default 10)
* `maxLength` - maximum length of a paste (default none)
* `staticMaxAge` - max age for static assets (86400)
* `recompressStatisAssets` - whether or not to compile static js assets (true)
* `documents` - static documents to serve (ex: http://hastebin.com/about.com)
  in addition to static assets.  These will never expire.
* `storage` - storage options (see below)
* `logging` - logging preferences
* `keyGenerator` - key generator options (see below)

## Details

For easy use the details are almost equal to the originals. You can find original configuration documentation at [John's github page](https://github.com/seejohnrun/haste-server/blob/master/README.md)

### Key Generation

#### Phonetic

Attempts to generate phonetic keys, similar to `pwgen`

``` json
{
  "type": "phonetic"
}
```

#### Random

Generates a random key

``` json
{
  "type": "random",
  "keyspace": "abcdef"
}
```

The _optional_ keySpace argument is a string of acceptable characters
for the key.

### Storage

#### File

To use file storage (the default) change the storage section in `config.js` to
something like:

``` json
{
  "path": "./data",
  "type": "file"
}
```

Where `path` represents where you want the files stored

#### Redis

To use redis storage you must install the redis package in npm

`npm install redis`

Once you've done that, your config section should look like:

``` json
{
  "type": "redis",
  "host": "localhost",
  "port": 6379,
  "db": 2
}
```

You can also set an `expire` option to the number of seconds to expire keys in.
This is off by default, but will constantly kick back expirations on each view
or post.

All of which are optional except `type` with very logical default values.

#### Memcached

To use memcached storage you must install the `memcache` package via npm

`npm install memcache`

Once you've done that, your config section should look like:

``` json
{
  "type": "memcached",
  "host": "127.0.0.1",
  "port": 11211
}
```

You can also set an `expire` option to the number of seconds to expire keys in.
This behaves just like the redis expirations, but does not push expirations
forward on GETs.

All of which are optional except `type` with very logical default values.

# Clients

## Web
After starting the container you can navigate to 'targethost:targetport' and start using the bin via your browser.

## Linux & OSX (ruby)
### Install

Usually ruby is provided by OSX basic installation.

If your Linux Distro doesn't have ruby, you may want to install it. You should include the dev variant, as several games depend on them e.g.

#### Ubuntu/Debian
```bash
apt-get install ruby-dev
```

#### RHEL/CentOS
```bash
yum install ruby-dev
```
### Client Install

After you ensure to have ruby installed use the following instruction.

```bash
gem install haste
```
### Usage
#### Add Content
```bash
cat file | haste
```
#### Read content
```bash
haste file
```

## Non-Ruby install
For those who don't like great ruby stuff - you may use following script as an alternative.

``` bash
haste() { a=$(cat); curl -X POST -s -d "$a" http://hastebin.com/documents | awk -F '"' '{print "http://hastebin.com/"$4}'; }
```

## Windows
If you want to acces via Windows have a look at [Aidan Ryan's WinHaste](https://github.com/ajryan/WinHaste)

# Issues

For issues please stick to [github's issue tracker](https://github.com/mko-x/docker-pastebin/issues).

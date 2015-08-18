# Eve

Eve is a set of tools to help us think. Currently, those tools include a database, a temporal logic query language, and an IDE.

- [https://github.com/witheve/Eve](https://github.com/witheve/Eve)

## Quick start

Eve relies in a fair amount of software, in order to avoid trashing the main system, the following vagrant recipes can be used to use it from a VM.

You will need [vagrant](https://www.vagrantup.com/) + [virtualbox](https://www.virtualbox.org/) to run this.

```
git clone --depth=1 https://github.com/chilicuil/eve-vagrant
cd eve-vagrant
vagrant up
```

After that opening [http://localhost:8080/editor](http://localhost:8080/editor) should take you to Eve

## Partial

The default recipe (above) uses an empty precise 32 box from which Eve and its dependencies are installed on every `vagrant up`. To reduce the time on this stage a partial recipe is provided which uses a modified precise box (583MB) with eve dependencies pre-installed to accelerate the process.

```
git clone --depth=1 https://github.com/chilicuil/eve-vagrant
cd eve-vagrant/partial
vagrant up
```

After that opening [http://localhost:8080/editor](http://localhost:8080/editor) should take you to Eve

# Gollum Installation (refer to [here](https://github.com/gollum/gollum/wiki/Installation))

## **Ubuntu**

Install `gollum` system-wide:
```
sudo apt-get install ruby ruby-dev make zlib1g-dev libicu-dev build-essential git cmake
sudo gem install gollum
```

That will cover the most basic installation on a local machine. If you are planning to install Gollum on a server, you can follow the third party [Gollum installation guide](https://projects.davidplanella.org/open-source/gollum-wiki-installation).

* On Ubuntu 14.04 LTS, the Ruby packages to install are `ruby1.9.1` and `ruby1.9.1-dev`

* You might also need to manually install `github-markdown` (e.g. if markdown tables don't render properly. See this issue for more explanation):
```
sudo gem install github-markdown
```

## **Windows**
 
> Warning: Windows support is still in the works! [Many things do not work right now](https://github.com/gollum/gollum/issues/1044), and [many of the tests are currently failing](https://github.com/gollum/gollum/issues/1044#issuecomment-126784479). Proceed at your own risk!

First, install [JRuby](http://jruby.org/download) and then:
```
~$ gem install gollum
```
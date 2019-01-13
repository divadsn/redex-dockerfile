# redex-dockerfile

Facebook's excellent [redex](https://github.com/facebook/redex) dex-optimizer while being amazingly good at it's job
is also an exceeding pain in the ass to compile, requiring archaic g++ 4.8 to compile successfully. This Dockerfile
recreates this garbage environment in a nice and easy container for the smarter ones among us who know better than
to muck up their PC.

## Usage

Clone this repo, then run `sudo docker build .` to build the image

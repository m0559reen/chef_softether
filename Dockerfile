FROM chef/chefdk:2

RUN chef gem install knife-zero --no-document

WORKDIR /chef

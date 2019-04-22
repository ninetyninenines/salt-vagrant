====================
Salt Vagrant Sandbox
====================

A SaltStack sandbox using Vagrant

Credit to UtahDave for the base creation of this project

Find the original project repo here: https://github.com/UtahDave/salt-vagrant-demo


Instructions
============

Run the following commands in a terminal. Git, VirtualBox and Vagrant must
already be installed.

.. code-block:: bash

    git clone git@github.com:ninetyninenines/salt-vagrant.git
    cd salt-vagrant
    vagrant plugin install vagrant-vbguest
    vagrant up


This will download an Ubuntu, Fedora and CentOS VirtualBox image and create four virtual
machines for you. The salt master will run on Ubuntu. The three minions will run on Ubuntu, 
Fedora and CentOS allowing to test confgurations across multiple Linux flavors. 
One will be a Salt Master named `master` and three will be Salt
Minions named `minion1`, `minion2` and `minion3`.  The Salt Minions will point to the Salt
Master and the Minion's keys will already be accepted. Because the keys are
pre-generated and reside in the repo, this is NOT intended for use in production.

You can then run the following commands to log into the Salt Master and begin
using Salt.

.. code-block:: bash

    vagrant ssh master
    sudo salt \* test.ping

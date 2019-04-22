{% set os = salt['grains.get']('os') %}
{% set osmajorrelease = salt['grains.get']('osmajorrelease') %}

python-pip:
  pkg.installed:
    - pkgs:
    {% if os == 'CentOS' or os == 'Fedora' %}
      - python2-pip
    {% elif os == 'Ubuntu' %}
      - python-pip
    {% endif %}
  pip.installed:
    - name: docker

docker-repo:
  pkgrepo.managed:
    - humanname: Docker Official
    {% if os == 'CentOS' %}
    - gpgkey: https://download.docker.com/linux/centos/gpg
    - gpgcheck: 1
    - baseurl: https://download.docker.com/linux/centos/$releasever/$basearch/stable
    {% elif os == 'Ubuntu' %}
    - name: deb https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg
    {% elif os == 'Fedora' %}
    - name: docker-ce
    - baseurl: https://download.docker.com/linux/fedora/$releasever/$basearch/stable
    - gpgcheck: 1
    - gpgkey: https://download.docker.com/linux/fedora/gpg
    {% endif %}

docker:
  pkg.installed:
    - pkgs:
      {% if salt['pillar.get']('docker:'+ os +':docker-ce:'+ osmajorrelease|string) and salt['pillar.get']('docker:'+ os +':docker-ce-cli:'+ osmajorrelease|string) %}
      - docker-ce: {{ salt['pillar.get']('docker:'+ os +':docker-ce:'+ osmajorrelease|string) }}
      - docker-ce-cli: {{ salt['pillar.get']('docker:'+ os +':docker-ce-cli:'+ osmajorrelease|string) }}
      {% else %}
      - docker-ce
      - docker-ce-cli
      {% endif %}
    - require:
      - pkgrepo: docker-repo
  service.running:
    - enable: True

docker-py:
  pip.installed:
    - name: docker

restart_minion:
  service.running:
    - name: salt-minion
    - enable: True
    - require:
      - service: docker
      - pip: docker-py
    - watch:
      - pip: docker-py

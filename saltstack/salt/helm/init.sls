{% set current_path = salt['environ.get']('PATH', '/bin:/usr/bin') %}
{% set ct_version = salt['pillar.get']('chart-testing:version') %}

helm:
  file.managed:
    - name: /tmp/get_helm.sh
    - source: https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get
    - mode: 700
    - skip_verify: true
  cmd.run:
    - name: /tmp/get_helm.sh
    - env:
      - PATH: {{ [current_path, '/usr/local/bin']|join(':') }}
    - require:
      - file: /tmp/get_helm.sh

/root/.helm/plugins:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: true
    - recurse:
      - user
      - group
      - mode

helmpush:
  environ.setenv:
    - name: HELM_HOME
    - value: /root/.helm
  cmd.run:
    - name: /usr/local/bin/helm plugin install https://github.com/chartmuseum/helm-push
    - require:
      - file: helm
      - file: /root/.helm/plugins

chart_testing:
  archive.extracted:
    - name: {{ '/opt/ct/chart-testing_'+ ct_version }}
    - source: {{ 'https://github.com/helm/chart-testing/releases/download/v'+ ct_version +'/chart-testing_'+ ct_version +'_linux_amd64.tar.gz' }}
    - source_hash: {{ salt['pillar.get']('chart-testing:hash') }}
    - enforce_toplevel: false
    - if_missing: {{ '/opt/ct/chart-testing_'+ ct_version }}
    - overwrite: true
  file.managed:
    - name: /usr/local/bin/ct
    - source: {{ '/opt/ct/chart-testing_'+ ct_version +'/ct' }}
    - mode: 775
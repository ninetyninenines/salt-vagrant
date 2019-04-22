docker:
  Ubuntu:
    docker-ce:
      16: 5:18.09.4~3-0~ubuntu-xenial
      18: 5:18.09.4~3-0~ubuntu-bionic
    docker-ce-cli:
      16: 5:18.09.4~3-0~ubuntu-xenial
      18: 5:18.09.4~3-0~ubuntu-bionic
  CentOS:
    docker-ce:
      7: 3:18.09.4-3.el7
    docker-ce-cli:
      7: 1:18.09.4-3.el7
  Fedora:
    docker-ce:
      28: 3:18.09.4-3.fc28
      29: 3:18.09.4-3.fc29
    docker-ce-cli:
      28: 1:18.09.4-3.fc28
      29: 1:18.09.4-3.fc29

chart-testing:
  version: '2.3.0'
  hash: c1f52de89f6d4332921e420bae3335e76ab454e4927391e98f3a94e592b60a65
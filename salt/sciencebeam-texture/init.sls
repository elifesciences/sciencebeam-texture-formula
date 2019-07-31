sciencebeam-texture-docker-compose-folder:
    file.directory:
        - name: /home/{{ pillar.elife.deploy_user.username }}/sciencebeam-texture
        - user: {{ pillar.elife.deploy_user.username }}
        - group: {{ pillar.elife.deploy_user.username }}
        - recurse:
            - user
            - group

sciencebeam-texture-docker-compose-.env:
    file.managed:
        - name: /home/{{ pillar.elife.deploy_user.username }}/sciencebeam-texture/.env
        - source: salt://sciencebeam-texture/config/home-deployuser-sciencebeam-texture-.env
        - makedirs: True
        - template: jinja
        - require:
            - sciencebeam-texture-docker-compose-folder
            # rendering this template calls Docker commands that may expect /ext to exist. 
            # if enabled, ensure /ext is present before rendering
            - mount-external-volume

sciencebeam-texture-docker-compose-yml:
    file.managed:
        - name: /home/{{ pillar.elife.deploy_user.username }}/sciencebeam-texture/docker-compose.yml
        - source: salt://sciencebeam-texture/config/home-deployuser-sciencebeam-texture-docker-compose.yml
        - template: jinja
        - require:
            - sciencebeam-texture-docker-compose-folder

sciencebeam-texture-docker-containers:
    cmd.run:
        - name: |
            /usr/local/bin/docker-compose up --force-recreate -d
        - user: {{ pillar.elife.deploy_user.username }}
        - cwd: /home/{{ pillar.elife.deploy_user.username }}/sciencebeam-texture
        - require:
            - sciencebeam-texture-docker-compose-.env
            - sciencebeam-texture-docker-compose-yml

sciencebeam-texture-nginx-vhost:
    file.managed:
        - name: /etc/nginx/sites-enabled/sciencebeam-texture.conf
        - source: salt://sciencebeam-texture/config/etc-nginx-sites-enabled-sciencebeam-texture.conf
        - template: jinja
        - require:
            - nginx-config
        - listen_in:
            - service: nginx-server-service

sciencebeam-texture-smoke-tests:
    file.managed:
        - name: /home/{{ pillar.elife.deploy_user.username }}/sciencebeam-texture/smoke_tests.sh
        - source: salt://sciencebeam-texture/config/home-deployuser-sciencebeam-texture-smoke_tests.sh
        - template: jinja
        - user: {{ pillar.elife.deploy_user.username }}
        - mode: 755
        - require:
            - sciencebeam-texture-docker-compose-folder

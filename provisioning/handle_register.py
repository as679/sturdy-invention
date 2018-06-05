#!/usr/bin/env python

import redis
import json
r = redis.StrictRedis(host='localhost', port=6379, db=0)
p = r.pubsub()
p.subscribe('instances')
for m in p.listen():
    if m['type'] == 'message':
        data = json.loads(m['data'])
        for k, v in data.iteritems():
            if 'localhostname' in v and v['localhostname'] is not None:
                try:
                    localhostname = v['localhostname'].split('_')
                    localhostname = localhostname[-2] + "." + localhostname[-1]
                except IndexError:
                    localhostname = v['localhostname'].split('-')
                    localhostname = localhostname[-2] + "." + localhostname[-1]
                if 'privateIp' in v:
                    if v['privateIp'] is not None:
                        if 'server' in v['localhostname']:
                            r.sadd('servers', v['privateIp'])
                        if 'kali' in v['localhostname']:
                            r.sadd('kalis', v['privateIp'])
                        if 'controller' in v['localhostname']:
                            r.sadd('controllers', v['privateIp'])
                        with open('/etc/hosts', 'a') as fh:
                            fh.write("%s\t%s\n" % (v['privateIp'], localhostname))
                if 'public-ipv4' in v:
                    if v['public-ipv4'] is not None:
                        with open('/etc/hosts', 'a') as fh:
                            fh.write("%s\t%s.public\n" % (v['public-ipv4'], localhostname))

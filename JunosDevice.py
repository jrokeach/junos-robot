from jnpr.junos import Device
from lxml import etree
from xmltodict import parse

class JunosDevice(object):

    def __init__(self):
        self.device = None

    def connect(self, host, user, password, port=22):
        self.device = Device(host, port=port, user=user, password=password)
        self.device.open()
        self.facts = self.device.facts

    def close(self):
        self.device.close()

    def get_hostname(self):
        return self.facts["hostname"]

    def get_model(self):
        return self.facts["model"]

    def get_version(self):
        return self.facts["version"]

    def get_bgp_peers(self):
        r = self.device.rpc.get_bgp_neighbor_information()
        peers = parse(etree.tostring(r))
        peers = peers['bgp-information']['bgp-peer']
        return peers

    def bgp_peer_count(self, status=None):
        peers = self.get_bgp_peers()
        if not status:
            peercount = len(peers)
        else:
            peercount = 0
            for peer in peers:
                if peer['peer-state'] == status:
                    peercount += 1
        return peercount
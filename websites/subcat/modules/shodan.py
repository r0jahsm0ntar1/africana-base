import navigator

from config import Config

URL_API = 'https://api.shodan.io/dns/domain/{0}?key={1}'
DOMAINS_LIST = []


def returnDomains(domain, silent=False):
    req = navigator.Navigator()
    keys = Config().read('shodan')
    if keys:
        for key in keys:
            json = req.downloadResponse(URL_API.format(domain, key), 'JSON', 'GET')
            try:
                for _ in json['subdomains']:
                    DOMAINS_LIST.append('{0}.{1}'.format(_, domain))
                if not silent:
                    req.ModuleLoaded('shodan.io', DOMAINS_LIST)
                return DOMAINS_LIST
            except:
                return []
        else:
            return []

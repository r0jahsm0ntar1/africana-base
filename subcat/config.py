import yaml
import os


class Config:
    def __init__(self, config='config.yaml'):
        dir_path = os.path.dirname(os.path.realpath(__file__))
        self.config = dir_path + '/' + config

    def read(self, module):
        try:
            data = yaml.safe_load(open(self.config))
            return data[module]
        except:
            return False
